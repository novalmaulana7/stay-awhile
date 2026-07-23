import 'package:firebase_auth/firebase_auth.dart';

/// Remote datasource for splash operations.
/// Checks authentication state on app startup.
class SplashRemoteDataSource {
  final FirebaseAuth _auth;

  SplashRemoteDataSource({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  /// Returns the current Firebase user if signed in, null otherwise.
  // TODO: API - Replace with proper session/token check if needed
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
