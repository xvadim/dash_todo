import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/sync_type_provider.dart';
import '../../../files/data/dropbox_files_repository.dart';
import '../../../files/data/tutorial_files_repository.dart';
import '../../../files/domain/repos/base_files_repository.dart';
import '../../data/tasks_repository.dart';
import '../../domain/task.dart';
import '../../domain/todos.dart';
import 'tasks_filter_controller.dart';

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

  //TODO: consider a special controller for upload
  Future<void> uploadTasks() async {
    //TODO: notify about upload result
    await _uploadTasks();
  }

  Future<void> completeTask(Task task) async {
    final tasksRepo = ref.read(tasksRepositoryProvider);
    final archive = ref.read(syncTypeProvider).isArchiveEnabled;
    final tasks = await tasksRepo.completeTask(task, archive: archive);
    await _updateState(tasks);
  }

  Future<void> deleteTask(Task task) async {
    final tasksRepo = ref.read(tasksRepositoryProvider);
    final tasks = await tasksRepo.deleteTask(task);
    await _updateState(tasks);
  }

  Future<void> _updateState(List<Task> tasks) async {
    final prevTodos = state.valueOrNull;
    if (prevTodos != null) {
      final newTodos = prevTodos.copyWith(tasks: tasks);
      state = await AsyncValue.guard(() async {
        return newTodos;
      });
    }
  }

  Future<Todos> _downloadTasks() async {
    //TODO: use FilesRepo factory
    late BaseFilesRepository filesRepo;
    if (ref.read(syncTypeProvider).syncType == SyncType.dropbox) {
      filesRepo = ref.read(dropboxFilesRepositoryProvider);
    } else {
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      filesRepo = ref.read(tutorialFilesRepositoryProvider);
    }
    String? todoFile;
    String? archiveFile;
    (todoFile, archiveFile) = await filesRepo.downloadTasks();
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

  Future<void> _uploadTasks() async {
    final tasksRepo = ref.read(tasksRepositoryProvider);
    final (todoFile, archiveFile) = await tasksRepo.exportTasks();
    final dropboxFilesRepo = ref.read(dropboxFilesRepositoryProvider);
    await dropboxFilesRepo.uploadTasks(
      localTodoFile: todoFile,
      localArchiveFile: archiveFile,
    );
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
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final filter = ref.watch(tasksFilterControllerProvider);
  if (state case AsyncData(value: final todos)) {
    late List<Task> tasks;
    if (filter.project == null || !filter.project!.startsWith('+')) {
      tasks = List<Task>.from(todos.tasks, growable: false);
    } else {
      final project = filter.project!.substring(1);
      tasks = todos.tasks
          .where(
            (t) => t.projects.contains(project),
          )
          .toList();
    }
    tasks.sort((a, b) => a.compareTo(b));
    //TODO: process categories
    return AsyncData(todos.copyWith(tasks: tasks));
  } else {
    return state;
  }
}
