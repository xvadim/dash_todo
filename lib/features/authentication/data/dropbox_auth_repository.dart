import 'package:dropbox_client/dropbox_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/env.dart';
import '../../settings/data/settings_repository.dart';

part 'dropbox_auth_repository.g.dart';

class DropboxAuthRepository {
  DropboxAuthRepository(this._settingsRepository);

  bool get isAuthorized => _settingsRepository.dropboxCredentials() != null;

  Future<void> authorize() async {
    if (!_isInitialized) {
      await _init();
    }
    await Dropbox.authorizePKCE();
  }

  Future<bool> login() async {
    if (!_isInitialized) {
      await _init();
    }

    String? credentials = _settingsRepository.dropboxCredentials();
    if (credentials == null) {
      credentials = await Dropbox.getCredentials();
      if (credentials == null) {
        return false;
      }
      _settingsRepository.saveDropboxCredentials(credentials);
    }

    String? testCredentials;
    //ignore: unnecessary_null_comparison
    if (credentials != null) {
      await Dropbox.authorizeWithCredentials(credentials);
      testCredentials = await Dropbox.getCredentials();
    }
    //TODO: get account info if needed
    //...
    return testCredentials != null;
  }

  Future<void> logout() async {
    await _settingsRepository.unlinkDropbox();
    await Dropbox.unlink();
  }

  final SettingsRepository _settingsRepository;
  bool _isInitialized = false;

  static const String _dropboxClientId = 'dash-todo-dropbox';

  Future<void> _init() async {
    await Dropbox.init(_dropboxClientId, Env.dropboxAppKey, Env.dropboxSecret);

    _isInitialized = true;
  }

  /*
  Future<void> _getAccountInfo() async {
    final result = await Dropbox.listFolder('/сделать');
    print(result);

    final name = await Dropbox.getAccountName();
    print('NAME: $name');

    final acc = await Dropbox.getCurrentAccount(forceCredentialsUse: true);
    print('ACC: ${acc?.name?.displayName} == ${acc?.profilePhotoUrl}');
  }
   */
}

@Riverpod(keepAlive: true)
DropboxAuthRepository dropboxAuthRepository(DropboxAuthRepositoryRef ref) {
  return DropboxAuthRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
