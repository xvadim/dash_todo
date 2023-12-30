import 'package:dropbox_client/dropbox_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/env.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/repos/authorizeable_auth_repository.dart';

part 'dropbox_auth_repository.g.dart';

class DropboxAuthRepository implements AuthorizableAuthRepository {
  DropboxAuthRepository(this._settingsRepository);

  @override
  bool get isAuthorized => _settingsRepository.dropboxCredentials() != null;
  @override
  String? get userName => _userName;
  @override
  String? get userEmail => _userEmail;
  @override
  String? get userAvatarUrl => _userAvatarUrl;

  @override
  Future<void> authorize() async {
    if (!_isInitialized) {
      await _init();
    }
    await Dropbox.authorizePKCE();
  }

  @override
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

    await _loadDropboxAccount();

    return testCredentials != null;
  }

  @override
  Future<void> logout() async {
    await _settingsRepository.unlinkDropbox();
    // doesn't return ??
    await Dropbox.unlink();
  }

  final SettingsRepository _settingsRepository;
  bool _isInitialized = false;
  String? _userName;
  String? _userEmail;
  String? _userAvatarUrl;

  static const String _dropboxClientId = 'dash-todo-dropbox';

  Future<void> _init() async {
    await Dropbox.init(
      _dropboxClientId,
      Env.dropboxAppKey,
      Env.dropboxSecret,
    );

    _isInitialized = true;
  }

  Future<void> _loadDropboxAccount() async {
    final account = await Dropbox.getCurrentAccount(
      forceCredentialsUse: true,
    );
    if (account != null) {
      _userName = account.name?.displayName;
      _userEmail = account.email;
      _userAvatarUrl = account.profilePhotoUrl;
    }

    _userName ??= await Dropbox.getAccountName();
  }
}

@Riverpod(keepAlive: true)
DropboxAuthRepository dropboxAuthRepository(DropboxAuthRepositoryRef ref) {
  return DropboxAuthRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
