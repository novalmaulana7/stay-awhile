abstract class RegisterRepository {
  Future<String> registerWithEmail({
    required String fullName,
    required String email,
    required String password,
  });

  Future<String> registerWithGoogle();

  Future<String> registerWithApple();
}
