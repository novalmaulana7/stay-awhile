import 'package:stay_awhile_mobile/feature/explore/data/datasources/explore_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepositoryImpl({
    required ExploreRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Stream<List<NearbyMessage>> getNearbyMessages({
    required double lat,
    required double lng,
    required double radiusKm,
  }) {
    try {
      return _remoteDataSource.getNearbyMessages(
        lat: lat,
        lng: lng,
        radiusKm: radiusKm,
      );
    } catch (e) {
      throw Exception('Failed to load nearby messages: ${e.toString()}');
    }
  }
}
