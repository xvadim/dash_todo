import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../settings/data/settings_repository.dart';
import '../../domain/app_user.dart';

part 'app_user_controller.g.dart';

class AppUserController {
  AppUserController(this._settingsRepository);
  ValueNotifier<AppUser?> get appUser => _appUser;
  bool get isAuthorized => _appUser.value != null;

  Future<void> setupUser({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    _appUser.value = AppUser(
      name: name ?? '',
      email: email ?? '',
      avatarUrl: avatarUrl ?? '',
    );

    await _settingsRepository.saveAppUserInfo(
      appUserName: _appUser.value!.name,
      appUserEmail: _appUser.value!.email,
      appUserAvatarUrl: _appUser.value!.avatarUrl,
    );
  }

  Future<void> loadUser() async {
    String userName = _settingsRepository.appUserName;
    if (userName.isNotEmpty) {
      _appUser.value = AppUser(
        name: userName,
        email: _settingsRepository.appUserEmail,
        avatarUrl: _settingsRepository.appUserAvatarUrl,
      );
    }
  }

  Future<void> logout() async {
    await _settingsRepository.removeAppUser();
    _appUser.value = null;
  }

  final SettingsRepository _settingsRepository;
  final ValueNotifier<AppUser?> _appUser = ValueNotifier(null);
}

@Riverpod(keepAlive: true)
AppUserController appUserController(AppUserControllerRef ref) {
  return AppUserController(
    ref.watch(settingsRepositoryProvider).requireValue,
  );
}
