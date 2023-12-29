import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/logger.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/dropbox_item.dart';
import '../domain/file_item.dart';
import '../domain/repos/browseable_files_repository.dart';

part 'dropbox_files_repository.g.dart';

class DropboxFilesRepository implements BrowseableFilesRepository {
  DropboxFilesRepository(this._settingsRepository);

  @override
  Future<List<FileItem>> listFolder([String folder = '']) async {
    final List<Object?> result = await Dropbox.listFolder(folder);

    return result
        .map((e) => DropboxItem.fromMap(e as Map<Object?, Object?>))
        .toList();
  }

  @override
  Future<(String? todoFile, String? archiveFile)> downloadTasks() async {
    String? todoFile = _settingsRepository.todoRemoteFile;
    String? archiveFile = _settingsRepository.archiveRemoteFile;
    if (todoFile == null || archiveFile == null) {
      logger.i('Todo or Done files are not set');
      return (null, null);
    }

    final Directory tempDir = await getTemporaryDirectory();
    final localTodoFile = '${tempDir.path}/todo.txt';
    final localArchiveFile = '${tempDir.path}/done.txt';

    await Dropbox.download(todoFile, localTodoFile);
    await Dropbox.download(archiveFile, localArchiveFile);

    return (localTodoFile, localArchiveFile);
  }

  @override
  Future<void> uploadTasks({
    required String localTodoFile,
    required String localArchiveFile,
  }) async {
    String? todoFile = _settingsRepository.todoRemoteFile;
    String? archiveFile = _settingsRepository.archiveRemoteFile;
    if (todoFile == null || archiveFile == null) {
      logger.i('Todo or Done files are not set');
    }

    await Dropbox.upload(localTodoFile, todoFile!);
    await Dropbox.upload(localArchiveFile, archiveFile!);
  }

  final SettingsRepository _settingsRepository;
}

@riverpod
DropboxFilesRepository dropboxFilesRepository(DropboxFilesRepositoryRef ref) {
  return DropboxFilesRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
