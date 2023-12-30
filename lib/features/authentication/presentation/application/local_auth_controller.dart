import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/local_auth_repository.dart';
import 'app_user_controller.dart';

part 'local_auth_controller.g.dart';

//TODO: common code
@riverpod
class LocalAuthController extends _$LocalAuthController {
  @override
  FutureOr<bool> build() async {
    return true;
  }

  Future<void> login() async {
    final authRepository = ref.read(tutorialAuthRepositoryProvider);
    state = await AsyncValue.guard(authRepository.login);

    //always successful login
    final appUserCtr = ref.read(appUserControllerProvider);
    await appUserCtr.setupUser(
      name: authRepository.userName,
      email: authRepository.userEmail,
      avatarUrl: authRepository.userAvatarUrl,
    );
  }

  Future<void> logout() async {
    final authRepository = ref.read(tutorialAuthRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await authRepository.logout();
      return true;
    });
  }
}
