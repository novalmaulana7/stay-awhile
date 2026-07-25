import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class DropRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DropRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Uploads image to a temporary hosting solution.
  /// TODO: API — replace with Firebase Storage upload when ready.
  Future<String?> uploadImage(File imageFile) async {
    // TODO: API — implement Firebase Storage upload
    return null;
  }

  Future<void> dropMessage({
    required String text,
    required String category,
    required double lat,
    required double lng,
    String? locationLabel,
    String? imageUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final geoFirePoint = GeoFirePoint(GeoPoint(lat, lng));

    await GeoCollectionReference(
      _firestore.collection('messages'),
    ).add({
      'geo': geoFirePoint.data,
      'authorId': user.uid,
      'authorName': user.displayName ?? 'Anonymous',
      'text': text,
      'category': category,
      'imageUrl': imageUrl,
      'locationLabel': locationLabel,
      'createdAt': FieldValue.serverTimestamp(),
      'likeCount': 0,
    });

    await _firestore.collection('users').doc(user.uid).update({
      'messagesDropped': FieldValue.increment(1),
    });
  }
}
