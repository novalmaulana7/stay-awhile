import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RegisterRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  RegisterRemoteDataSource({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> registerWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(fullName);
    await _createUserDocument(credential.user!, fullName: fullName);
    return credential;
  }

  Future<UserCredential> registerWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await _auth.signInWithCredential(credential);
    await _createUserDocument(result.user!);
    return result;
  }

  Future<UserCredential> registerWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    final result = await _auth.signInWithCredential(oauthCredential);
    await _createUserDocument(result.user!);
    return result;
  }

  Future<void> _createUserDocument(
    User user, {
    String? fullName,
  }) async {
    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'displayName': fullName ?? user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL,
        'bio': null,
        'joinDate': FieldValue.serverTimestamp(),
        'messagesDropped': 0,
        'messagesFound': 0,
      });
    }
  }
}
