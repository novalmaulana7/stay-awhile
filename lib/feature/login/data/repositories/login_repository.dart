abstract class LoginRepository {
  /// Login with email and password.
  Future<String> loginWithEmail({
    required String email,
    required String password,
  });

  /// Login with Google.
  Future<String> loginWithGoogle();

  /// Login with Apple.
  Future<String> loginWithApple();
}