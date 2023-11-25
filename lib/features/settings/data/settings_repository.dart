import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  SettingsRepository(this._sharedPrefs);

  final SharedPreferences _sharedPrefs;
}

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(
  SettingsRepositoryRef ref,
) async {
  return SettingsRepository(await SharedPreferences.getInstance());
}
