import 'package:dropbox_client/dropbox_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  final SettingsRepository _settingsRepository;
}

@Riverpod(keepAlive: true)
DropboxFilesRepository dropboxFilesRepository(DropboxFilesRepositoryRef ref) {
  return DropboxFilesRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
