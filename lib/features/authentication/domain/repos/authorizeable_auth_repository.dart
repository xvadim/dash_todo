import 'base_auth_repository.dart';

abstract class AuthorizableAuthRepository extends BaseAuthRepository {
  bool get isAuthorized;
  Future<void> authorize();
}
