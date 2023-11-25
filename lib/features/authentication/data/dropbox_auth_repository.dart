import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../settings/data/settings_repository.dart';

part 'dropbox_auth_repository.g.dart';

class DropboxAuthRepository {
  DropboxAuthRepository(this._settingsRepository);

  bool get isAuthorized => _settingsRepository.dropboxCredentials() != null;

  final SettingsRepository _settingsRepository;
}

@Riverpod(keepAlive: true)
DropboxAuthRepository dropboxAuthRepository(DropboxAuthRepositoryRef ref) {
  return DropboxAuthRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
