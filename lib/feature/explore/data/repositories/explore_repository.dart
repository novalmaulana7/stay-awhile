import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';

abstract class ExploreRepository {
  Future<List<NearbyMessage>> getNearbyMessages({
    required double radiusKm,
  });
}
