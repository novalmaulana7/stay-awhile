import 'package:firebase_auth/firebase_auth.dart';
import 'package:stay_awhile_mobile/feature/register/data/datasources/register_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/register/data/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;

  RegisterRepositoryImpl({
    required RegisterRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<String> registerWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.registerWithEmail(
        fullName: fullName,
        email: email,
        password: password,
      );
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<String> registerWithGoogle() async {
    try {
      final result = await _remoteDataSource.registerWithGoogle();
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  @override
  Future<String> registerWithApple() async {
    try {
      final result = await _remoteDataSource.registerWithApple();
      return result.user?.uid ?? '';
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception('Apple sign-in failed: ${e.toString()}');
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account with this email already exists';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled';
      default:
        return 'Registration failed: ${e.message ?? 'Unknown error'}';
    }
  }
}
