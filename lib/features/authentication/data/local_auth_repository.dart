import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/repos/base_auth_repository.dart';

part 'local_auth_repository.g.dart';

// The AuthRepository implementation for tutorial (built-in) tasks
class LocalAuthRepository implements BaseAuthRepository {
  @override
  String? get userName => 'You'.tr();

  @override
  String? get userEmail => '';

  @override
  String? get userAvatarUrl => '';

  @override
  Future<bool> login() async => Future.value(true);

  @override
  Future<void> logout() async {}
}

@riverpod
LocalAuthRepository tutorialAuthRepository(TutorialAuthRepositoryRef ref) {
  return LocalAuthRepository();
}
