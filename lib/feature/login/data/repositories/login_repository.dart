import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<String> loginWithEmail({
    required String email,
    required String password,
  });

  Future<String> loginWithGoogle();

  Future<String> loginWithApple();

  Future<void> createUserDocument(User user);
}
