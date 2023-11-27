import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  SettingsRepository(this._sharedPrefs);

  //#region Dropbox
  Future<void> saveDropboxCredentials(String credentials) async {
    await _sharedPrefs.setString(_keyDropboxCredentials, credentials);
  }

  String? dropboxCredentials() =>
      _sharedPrefs.getString(_keyDropboxCredentials);

  Future<void> unlinkDropbox() async {
    await _sharedPrefs.remove(_keyDropboxCredentials);
  }
  //#endregion

  //#region AppUser
  Future<void> saveAppUserInfo({
    required String appUserName,
    String? appUserEmail,
    String? appUserAvatarUrl,
  }) async {
    await Future.wait([
      _sharedPrefs.setString(_keyAppUserName, appUserName),
      _sharedPrefs.setString(_keyAppUserEmail, appUserEmail ?? ''),
      _sharedPrefs.setString(_keyAppUserAvatarUrl, appUserAvatarUrl ?? ''),
    ]);
  }

  String get appUserName => _sharedPrefs.getString(_keyAppUserName) ?? '';
  String get appUserEmail => _sharedPrefs.getString(_keyAppUserEmail) ?? '';
  String get appUserAvatarUrl =>
      _sharedPrefs.getString(_keyAppUserAvatarUrl) ?? '';

  Future<void> removeAppUser() async {
    await Future.wait([
      _sharedPrefs.remove(_keyAppUserName),
      _sharedPrefs.remove(_keyAppUserEmail),
      _sharedPrefs.remove(_keyAppUserAvatarUrl),
    ]);
  }
  //#endregion

  final SharedPreferences _sharedPrefs;

  static const _keyDropboxCredentials = 'dropboxCredentials';
  static const _keyAppUserName = 'appUserName';
  static const _keyAppUserEmail = 'appUserEmail';
  static const _keyAppUserAvatarUrl = 'appUserAvatarUrl';
}

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(
  SettingsRepositoryRef ref,
) async {
  return SettingsRepository(await SharedPreferences.getInstance());
}
