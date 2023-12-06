import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/logger.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/dropbox_item.dart';

part 'dropbox_files_repository.g.dart';

class DropboxFilesRepository {
  DropboxFilesRepository(this._settingsRepository);

  /// Returns folder/file list for path.
  Future<List<DropboxItem>> listFolder([String folder = '']) async {
    final List<Object?> result = await Dropbox.listFolder(folder);

    return result
        .map((e) => DropboxItem.fromMap(e as Map<Object?, Object?>))
        .toList();
  }

  Future<(String?, String?)> downloadTasks() async {
    String? todoFile = _settingsRepository.todoRemoteFile;
    String? archiveFile = _settingsRepository.archiveRemoteFile;
    if (todoFile == null && archiveFile == null) {
      logger.i('Todo and Done files are not set');
      return (null, null);
    }

    final Directory tempDir = await getTemporaryDirectory();
    final localTodoFile = '${tempDir.path}/todo.txt';
    final localArchiveFile = '${tempDir.path}/done.txt';

    await Dropbox.download(todoFile!, localTodoFile);
    await Dropbox.download(archiveFile!, localArchiveFile);

    return (localTodoFile, localArchiveFile);
  }

  Future<void> uploadTasks({
    required String localTodoFile,
    required String localArchiveFile,
  }) async {
    String? todoFile = _settingsRepository.todoRemoteFile;
    String? archiveFile = _settingsRepository.archiveRemoteFile;
    if (todoFile == null && archiveFile == null) {
      logger.i('Todo and Done files are not set');
    }

    print('UPLOAD TO DB: $todoFile -- $archiveFile');

    await Dropbox.upload(localTodoFile, todoFile!);
    await Dropbox.upload(localArchiveFile, archiveFile!);
  }

  final SettingsRepository _settingsRepository;
}

//TODO: do we need keepAlive?
@Riverpod(keepAlive: true)
DropboxFilesRepository dropboxFilesRepository(DropboxFilesRepositoryRef ref) {
  return DropboxFilesRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
