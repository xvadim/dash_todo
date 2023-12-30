abstract class BaseAuthRepository {
  String? get userName;
  String? get userEmail;
  String? get userAvatarUrl;

  Future<bool> login();
  Future<void> logout();
}
