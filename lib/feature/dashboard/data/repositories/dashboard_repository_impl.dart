import 'package:stay_awhile_mobile/feature/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl({
    required DashboardRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<MapMarker>> getMapMarkers() async {
    try {
      return await _remoteDataSource.getMapMarkers();
    } catch (e) {
      throw Exception('Failed to load markers: ${e.toString()}');
    }
  }

  @override
  Future<LocationInfo> getCurrentLocation() async {
    try {
      return await _remoteDataSource.getCurrentLocation();
    } catch (e) {
      throw Exception('Failed to load location: ${e.toString()}');
    }
  }

  @override
  Future<void> dropMessage({
    required String message,
    required String icon,
  }) async {
    try {
      await _remoteDataSource.dropMessage(message: message, icon: icon);
    } catch (e) {
      throw Exception('Failed to drop message: ${e.toString()}');
    }
  }
}
