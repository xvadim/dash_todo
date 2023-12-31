import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../settings/data/settings_repository.dart';

part 'sync_type_provider.g.dart';

enum SyncType { unset, dropbox, local, tutorial }

class SyncTypeProvider {
  SyncTypeProvider(this._settingsRepository) {
    final syncTypeIndex = _settingsRepository.syncTypeIndex;
    _syncType = SyncType.values[syncTypeIndex];
  }

  SyncType get syncType => _syncType;

  bool get isFilesSetupNeeded =>
      _syncType != SyncType.unset && _syncType != SyncType.tutorial;

  bool get isUploadEnabled => _syncType == SyncType.dropbox;

  bool get isArchiveEnabled => _syncType == SyncType.dropbox;

  Future<void> setSyncType(SyncType newType) async {
    _syncType = newType;
    await _settingsRepository.saveSyncType(_syncType.index);
  }

  final SettingsRepository _settingsRepository;
  late SyncType _syncType;
}

@Riverpod(keepAlive: true)
SyncTypeProvider syncType(SyncTypeRef ref) {
  return SyncTypeProvider(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
