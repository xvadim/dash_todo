import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/env.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/app_user.dart';

part 'dropbox_auth_repository.g.dart';

class DropboxAuthRepository {
  DropboxAuthRepository(this._settingsRepository);

  bool get isAuthorized => _settingsRepository.dropboxCredentials() != null;
  ValueNotifier<AppUser?> get appUser => _appUser;

  Future<void> authorize() async {
    if (!_isInitialized) {
      await _init();
    }
    await Dropbox.authorizePKCE();
  }

  Future<bool> login() async {
    print('LOGIN!!');
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

    await loadUser(forceRefresh: true);

    return testCredentials != null;
  }

  Future<void> logout() async {
    await _settingsRepository.unlinkDropbox();
    _appUser.value = null;
    await Dropbox.unlink();
  }

  final SettingsRepository _settingsRepository;
  bool _isInitialized = false;
  final ValueNotifier<AppUser?> _appUser = ValueNotifier(null);

  static const String _dropboxClientId = 'dash-todo-dropbox';

  Future<void> _init() async {
    print('DB INIT');
    await Dropbox.init(_dropboxClientId, Env.dropboxAppKey, Env.dropboxSecret);

    _isInitialized = true;
  }

  Future<void> loadUser({bool forceRefresh = false}) async {
    String userName = _settingsRepository.appUserName;
    if (userName.isEmpty) {
      if (forceRefresh) {
        await _loadDropboxAccount();
        userName = _settingsRepository.appUserName;
      } else {
        return;
      }
    }

    _appUser.value = AppUser(
      name: userName,
      email: _settingsRepository.appUserEmail,
      avatarUrl: _settingsRepository.appUserAvatarUrl,
    );
  }

  Future<void> _loadDropboxAccount() async {
    String? userName;
    String? userEmail;
    String? userAvatarUrl;
    final account = await Dropbox.getCurrentAccount(forceCredentialsUse: true);
    if (account != null) {
      userName = account.name?.displayName;
      userEmail = account.email;
      userAvatarUrl = account.profilePhotoUrl;
    }

    userName ??= await Dropbox.getAccountName();

    await _settingsRepository.saveAppUserInfo(
      appUserName: userName ?? '',
      appUserEmail: userEmail,
      appUserAvatarUrl: userAvatarUrl,
    );
  }
}

@Riverpod(keepAlive: true)
DropboxAuthRepository dropboxAuthRepository(DropboxAuthRepositoryRef ref) {
  return DropboxAuthRepository(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
