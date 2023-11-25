import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  SettingsRepository(this._sharedPrefs);

  Future<void> saveDropboxCredentials(String credentials) async {
    await _sharedPrefs.setString(_keyDropboxCredentials, credentials);
  }

  String? dropboxCredentials() =>
      _sharedPrefs.getString(_keyDropboxCredentials);

  final SharedPreferences _sharedPrefs;

  static const _keyDropboxCredentials = 'dropboxCredentials';
}

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(
  SettingsRepositoryRef ref,
) async {
  return SettingsRepository(await SharedPreferences.getInstance());
}
