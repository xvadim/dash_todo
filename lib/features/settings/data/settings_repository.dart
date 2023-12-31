import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  SettingsRepository(this._sharedPrefs);

  //#region SyncType
  int get syncTypeIndex => _sharedPrefs.getInt(_keySyncType) ?? 0;
  Future<void> saveSyncType(int index) async {
    await _sharedPrefs.setInt(_keySyncType, index);
  }
  //#enregion

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

  //#region Remote Files
  Future<void> saveRemotePaths({
    required String todoFile,
    required String archiveFile,
  }) async {
    await Future.wait([
      _sharedPrefs.setString(_keyTodoFilePath, todoFile),
      _sharedPrefs.setString(_keyArchiveFilePath, archiveFile),
    ]);
  }

  String? get todoRemoteFile => _sharedPrefs.getString(_keyTodoFilePath);
  String? get archiveRemoteFile => _sharedPrefs.getString(_keyArchiveFilePath);

  Future<void> removeFiles() async {
    await Future.wait([
      _sharedPrefs.remove(_keyTodoFilePath),
      _sharedPrefs.remove(_keyArchiveFilePath),
    ]);
  }
  //#endregion

  final SharedPreferences _sharedPrefs;

  static const _keyDropboxCredentials = 'dropboxCredentials';
  static const _keyAppUserName = 'appUserName';
  static const _keyAppUserEmail = 'appUserEmail';
  static const _keyAppUserAvatarUrl = 'appUserAvatarUrl';
  static const _keyTodoFilePath = 'todoFilePath';
  static const _keyArchiveFilePath = 'archiveFilePath';
  static const _keySyncType = 'syncType';
}

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(
  SettingsRepositoryRef ref,
) async {
  return SettingsRepository(await SharedPreferences.getInstance());
}
