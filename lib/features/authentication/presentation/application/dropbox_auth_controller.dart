import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/sync_type_provider.dart';
import '../../data/dropbox_auth_repository.dart';
import 'app_user_controller.dart';

part 'dropbox_auth_controller.g.dart';

@riverpod
class DropboxAuthController extends _$DropboxAuthController {
  @override
  FutureOr<bool> build() {
    return true;
  }

  Future<void> authorize() async {
    state = const AsyncLoading();
    final authRepository = ref.watch(dropboxAuthRepositoryProvider);
    await authRepository.authorize();
  }

  Future<void> login() async {
    final authRepository = ref.watch(dropboxAuthRepositoryProvider);
    state = await AsyncValue.guard(authRepository.login);
    if (state case AsyncData(:final value)) {
      if (value) {
        await ref.read(syncTypeProvider).setSyncType(SyncType.dropbox);
        // ignore: avoid_manual_providers_as_generated_provider_dependency
        final appUserCtr = ref.read(appUserControllerProvider);
        await appUserCtr.setupUser(
          name: authRepository.userName,
          email: authRepository.userEmail,
          avatarUrl: authRepository.userAvatarUrl,
        );
      }
    }
  }

  Future<void> logout() async {
    final authRepository = ref.watch(dropboxAuthRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await authRepository.logout();
      return true;
    });
  }
}
