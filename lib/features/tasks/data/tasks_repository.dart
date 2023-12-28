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
    final List<Task> tasks = todos
        .where((i) => i.isNotEmpty)
        .indexed
        .map(
          (e) => Task.fromString(e.$1, e.$2),
        )
        .toList();

    _tasks.clear();
    _tasks.addAll(tasks);

    _updateProjects();

    return Todos(tasks: tasks, projects: _projects);
  }

  Future<List<Task>> completeTask(Task task) async {
    _tasks = _tasks.where((t) => t.id != task.id).toList();
    final completedTask = task.complete();
    await _archiveTask(completedTask);
    //TODO: save only when needed
    await _saveTasks();

    return [..._tasks];
  }

  Future<List<Task>> deleteTask(Task task) async {
    _tasks = _tasks.where((t) => t.id != task.id).toList();
    //TODO: save only when needed
    await _saveTasks();

    return [..._tasks];
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

  Future<void> _archiveTask(Task task) async {
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    final doneFile = File(_localDoneFile(docDirectory));
    final taskStr = task.toRawString();
    await doneFile.writeAsString('$taskStr\n', mode: FileMode.append);
  }

  Future<void> _saveTasks() async {
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    final todoFile = File(_localTodoFile(docDirectory));
    final tasksStr = _tasks.map((t) => t.toRawString()).join('\n');
    await todoFile.writeAsString('$tasksStr\n');
  }

  String _localTodoFile(Directory directory) => '${directory.path}/todo.txt';
  String _localDoneFile(Directory directory) => '${directory.path}/done.txt';

  List<Task> _tasks = [];
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
