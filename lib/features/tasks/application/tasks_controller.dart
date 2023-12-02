import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../files_repository/data/dropbox_files_repository.dart';
import '../data/tasks_repository.dart';
import '../domain/task.dart';

part 'tasks_controller.g.dart';

@Riverpod(keepAlive: true)
class TasksController extends _$TasksController {
  @override
  FutureOr<List<Task>> build() async {
    final tasksRepo = ref.read(tasksRepositoryProvider);
    return tasksRepo.loadTasks();
  }

  Future<void> downloadTasks() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _downloadTasks());
  }

  Future<List<Task>> _downloadTasks() async {
    final dropboxFilesRepo = ref.read(dropboxFilesRepositoryProvider);
    String? todoFile;
    String? archiveFile;
    (todoFile, archiveFile) = await dropboxFilesRepo.downloadTasks();
    if (todoFile == null || archiveFile == null) {
      return [];
    }

    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final tasksRepo = ref.read(tasksRepositoryProvider);
    await tasksRepo.importTasks(
      todoFileName: todoFile,
      archiveFileName: archiveFile,
    );

    return await tasksRepo.loadTasks();
  }
}

// To improve performance, i.e. rebuild only changed tasks
final currentTask = Provider<Task>(
  (ref) => throw UnimplementedError(),
);
