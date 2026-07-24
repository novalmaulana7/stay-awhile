import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

abstract class ExploreRepository {
  Stream<List<NearbyMessage>> getNearbyMessages({
    required double lat,
    required double lng,
    required double radiusKm,
  });
}
