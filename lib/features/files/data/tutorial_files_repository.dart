import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/repos/base_files_repository.dart';

part 'tutorial_files_repository.g.dart';

class TutorialFilesRepository implements BaseFilesRepository {
  // Copy tutorial todo file from assets
  @override
  Future<(String?, String?)> downloadTasks() async {
    final Directory tempDir = await getTemporaryDirectory();
    final localTodoFile = '${tempDir.path}/todo.txt';
    final localArchiveFile = '${tempDir.path}/done.txt';

    //TODO: support UK locale
    final ByteData data = await rootBundle.load(
      'assets/tasks/tutorial_tasks_en.txt',
    );
    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    await Future.wait([
      File(localTodoFile).writeAsBytes(bytes),
      //just create an empty file
      File(localArchiveFile).writeAsString(''),
    ]);

    return (localTodoFile, localArchiveFile);
  }
}

@riverpod
TutorialFilesRepository tutorialFilesRepository(
  TutorialFilesRepositoryRef ref,
) {
  return TutorialFilesRepository();
}
