import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/dropbox_auth_repository.dart';

part 'dropbox_auth_controller.g.dart';

@riverpod
class DropboxAuthController extends _$DropboxAuthController {
  @override
  FutureOr<bool> build() {
    return true;
  }

  Future<void> authorize() async {
    print('CTRL AUTH');
    final authRepository = ref.watch(dropboxAuthRepositoryProvider);
    state = const AsyncLoading();
    await authRepository.authorize();
    // state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }

  Future<void> login() async {
    final authRepository = ref.watch(dropboxAuthRepositoryProvider);
    state = await AsyncValue.guard(authRepository.login);
  }
}
