import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/logger.dart';
import '../domain/task.dart';

part 'tasks_repository.g.dart';

class TasksRepository {
  Future<void> importTasks({
    required String todoFileName,
    required String archiveFileName,
  }) async {
    logger.d('Import from $todoFileName');
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    String localFileName = _localTodoFile(docDirectory);
    await _copyFile(todoFileName, localFileName);
    localFileName = _localDoneFile(docDirectory);
    await _copyFile(archiveFileName, localFileName);
  }

  Future<List<Task>> loadTasks() async {
    logger.d('Load tasks');
    final Directory docDirectory = await getApplicationDocumentsDirectory();
    final locTodoFileName = _localTodoFile(docDirectory);
    final todoFile = File(locTodoFileName);

    if (!todoFile.existsSync()) {
      logger.i("File $locTodoFileName doesn't exists");
      return [];
    }

    final todos = await todoFile.readAsLines();
    final List<Task> tasks = todos.indexed
        .map(
          (e) => Task.fromString(e.$1, e.$2),
        )
        .toList();
    //temporary
    tasks.sort((a, b) => a.rawString.compareTo(b.rawString));
    return tasks;
  }

  Future<void> _copyFile(String origName, String destName) async {
    logger.d('Copy $origName to $destName');
    final origFile = File(origName);
    if (!origFile.existsSync()) {
      logger.i("File $origName doesn't exists");
      return;
    }
    final destFile = File(destName);
    String content = await origFile.readAsString();
    await destFile.writeAsString(content, flush: true);
  }

  String _localTodoFile(Directory directory) => '${directory.path}/todo.txt';
  String _localDoneFile(Directory directory) => '${directory.path}/done.txt';
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  return TasksRepository();
}
