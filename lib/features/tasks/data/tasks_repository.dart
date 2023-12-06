import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/logger.dart';
import '../domain/task.dart';
import '../domain/todos.dart';

part 'tasks_repository.g.dart';

class TasksRepository {
  Future<void> importTasks({
    required String todoFileName,
    required String archiveFileName,
  }) async {
    logger.d('Import from $todoFileName');
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    String localFileName = _localTodoFile(docDirectory);
    await _copyFile(
      todoFileName,
      localFileName,
      deleteOrigin: true,
    );
    localFileName = _localDoneFile(docDirectory);
    await _copyFile(
      archiveFileName,
      localFileName,
      deleteOrigin: true,
    );
  }

  // Returns (todoFileName, archiveFileName)
  Future<(String, String)> exportTasks() async {
    final Directory tempDir = await getTemporaryDirectory();
    final todoFile = '${tempDir.path}/todo.txt';
    final archiveFile = '${tempDir.path}/done.txt';

    final Directory docDirectory = await getApplicationDocumentsDirectory();
    String localFileName = _localTodoFile(docDirectory);
    await _copyFile(localFileName, todoFile);

    localFileName = _localDoneFile(docDirectory);
    await _copyFile(localFileName, archiveFile);

    return (todoFile, archiveFile);
  }

  Future<Todos> loadTodos() async {
    logger.d('Load tasks');
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    final locTodoFileName = _localTodoFile(docDirectory);
    final todoFile = File(locTodoFileName);

    if (!todoFile.existsSync()) {
      logger.i("File $locTodoFileName doesn't exists");
      return const Todos(tasks: [], projects: {});
    }

    final todos = await todoFile.readAsLines();
    final List<Task> tasks = todos.indexed
        .map(
          (e) => Task.fromString(e.$1, e.$2),
        )
        .toList();
    //temporary
    tasks.sort((a, b) => a.rawString.compareTo(b.rawString));

    _tasks.clear();
    _tasks.addAll(tasks);

    _updateProjects();

    return Todos(tasks: _tasks, projects: _projects);
  }

  Future<void> _copyFile(
    String origName,
    String destName, {
    bool deleteOrigin = false,
  }) async {
    logger.d('Copy $origName to $destName');
    final origFile = File(origName);
    if (!origFile.existsSync()) {
      logger.i("File $origName doesn't exists");
      return;
    }
    await origFile.copy(destName);
    if (deleteOrigin) {
      await origFile.delete();
    }
  }

  String _localTodoFile(Directory directory) => '${directory.path}/todo.txt';
  String _localDoneFile(Directory directory) => '${directory.path}/done.txt';

  final List<Task> _tasks = [];
  final Set<String> _projects = {};

  void _updateProjects() {
    _projects.clear();
    for (final t in _tasks) {
      _updateProjectsFromTask(t);
    }
  }

  void _updateProjectsFromTask(Task task) => _projects.addAll(task.projects);
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  return TasksRepository();
}
