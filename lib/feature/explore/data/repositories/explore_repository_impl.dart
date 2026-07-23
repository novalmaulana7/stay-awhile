import 'package:stay_awhile_mobile/feature/explore/data/datasources/explore_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepositoryImpl({
    required ExploreRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<NearbyMessage>> getNearbyMessages({
    required double radiusKm,
  }) async {
    try {
      return await _remoteDataSource.getNearbyMessages(radiusKm: radiusKm);
    } catch (e) {
      throw Exception('Failed to load nearby messages: ${e.toString()}');
    }
  }
}
