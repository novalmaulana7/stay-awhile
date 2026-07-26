import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';

class DashboardRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DashboardRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<List<MapMarker>> getMapMarkers() async {
    final user = _auth.currentUser;
    final snapshot = await _firestore.collection('messages').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final geo = data['geo'] as Map<String, dynamic>?;
      final geopoint = geo?['geopoint'] as GeoPoint?;

      return MapMarker(
        id: doc.id,
        message: data['text'] as String? ?? '',
        icon: 'place',
        lat: geopoint?.latitude ?? 0,
        lng: geopoint?.longitude ?? 0,
        isOwn: user != null && (data['authorId'] as String?) == user.uid,
      );
    }).toList();
  }

  Future<LocationInfo> getCurrentLocation() async {
    // TODO: Replace with real geolocation + Firestore lookup
    return LocationInfo(
      name: 'Golden Gate Park',
      subtitle: 'Inner Sunset, San Francisco',
      description: '42 neighbors have left notes here today.',
      neighborCount: 42,
      avatarUrls: [],
    );
  }

  Future<void> dropMessage({
    required String text,
    required double lat,
    required double lng,
    String? locationLabel,
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
      'imageUrl': null,
      'locationLabel': locationLabel,
      'createdAt': FieldValue.serverTimestamp(),
      'likeCount': 0,
    });

    await _firestore.collection('users').doc(user.uid).update({
      'messagesDropped': FieldValue.increment(1),
    });
  }
}
