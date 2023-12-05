import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../files_repository/data/dropbox_files_repository.dart';
import '../data/tasks_repository.dart';
import '../domain/task.dart';
import '../domain/todos.dart';
import 'tasks_filter_contoller.dart';

part 'tasks_controller.g.dart';

@Riverpod(keepAlive: true)
class TasksController extends _$TasksController {
  @override
  FutureOr<Todos> build() async {
    final tasksRepo = ref.read(tasksRepositoryProvider);
    return tasksRepo.loadTodos();
  }

  Future<void> downloadTasks() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _downloadTasks());
  }

  Future<Todos> _downloadTasks() async {
    final dropboxFilesRepo = ref.read(dropboxFilesRepositoryProvider);
    String? todoFile;
    String? archiveFile;
    (todoFile, archiveFile) = await dropboxFilesRepo.downloadTasks();
    if (todoFile == null || archiveFile == null) {
      return const Todos(tasks: [], projects: {});
    }

    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final tasksRepo = ref.read(tasksRepositoryProvider);
    await tasksRepo.importTasks(
      todoFileName: todoFile,
      archiveFileName: archiveFile,
    );

    return await tasksRepo.loadTodos();
  }
}

// To improve performance, i.e. rebuild only changed tasks
final currentTask = Provider<Task>(
  (ref) => throw UnimplementedError(),
);

@riverpod
Future<Set<String>> projects(ProjectsRef ref) async {
  final todos = await ref.watch(tasksControllerProvider.future);
  return {
    'filter.allTasks'.tr(),
    ...todos.projects.map((e) => '+$e'),
  };
}

//TODO: return AsyncValue<List<Task>>
@riverpod
AsyncValue<Todos> filteredTasks(FilteredTasksRef ref) {
  final state = ref.watch(tasksControllerProvider);
  final filter = ref.watch(tasksFilterControllerProvider);
  if (state case AsyncData(value: final todos)) {
    late List<Task> tasks;
    if (filter.project == null || !filter.project!.startsWith('+')) {
      tasks = todos.tasks;
    } else {
      final project = filter.project!.substring(1);
      tasks = todos.tasks
          .where(
            (t) => t.projects.contains(project),
          )
          .toList();
    }
    /*
    List<Task> tasks = filter.project == null
        ? todos.tasks
        : todos.tasks
            .where((t) => t.projects.contains(filter.project))
            .toList();

     */
    //TODO: process categories
    return AsyncData(todos.copyWith(tasks: tasks));
  } else {
    return state;
  }
}
