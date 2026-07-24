import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

class ExploreRemoteDataSource {
  final FirebaseFirestore _firestore;

  ExploreRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<NearbyMessage>> getNearbyMessages({
    required double lat,
    required double lng,
    required double radiusKm,
  }) {
    final center = GeoFirePoint(GeoPoint(lat, lng));

    return GeoCollectionReference<Map<String, dynamic>>(
      _firestore.collection('messages'),
    )
        .subscribeWithin(
          center: center,
          radiusInKm: radiusKm,
          field: 'geo',
          geopointFrom: (data) =>
              (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
        )
        .map((snapshots) {
      final messages = snapshots.map((doc) {
        final data = doc.data();
        if (data == null) return null;
        return NearbyMessage.fromFirestore(data, doc.id);
      }).whereType<NearbyMessage>().toList();

      messages.sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });

      return messages;
    });
  }
}
