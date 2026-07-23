import 'package:firebase_auth/firebase_auth.dart';
import 'package:stay_awhile_mobile/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/login/data/repositories/login_repository.dart';

/// Implementation of LoginRepository.
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepositoryImpl({
    required LoginRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<String> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.loginWithEmail(
        email: email,
        password: password,
      );
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      // TODO: API - Handle specific error cases properly
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<String> loginWithGoogle() async {
    try {
      final result = await _remoteDataSource.loginWithGoogle();
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  @override
  Future<String> loginWithApple() async {
    try {
      final result = await _remoteDataSource.loginWithApple();
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('Apple sign-in failed: ${e.toString()}');
    }
  }

  /// Maps Firebase auth exceptions to user-friendly error messages.
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password. Please try again';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later';
      default:
        return 'Login failed: ${e.message ?? 'Unknown error'}';
    }
  }
}