import 'package:stay_awhile_mobile/feature/drop/data/datasources/drop_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/drop/data/repositories/drop_repository.dart';

class DropRepositoryImpl implements DropRepository {
  final DropRemoteDataSource _remoteDataSource;

  DropRepositoryImpl({required DropRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<void> dropMessage({
    required String text,
    required double lat,
    required double lng,
    String? locationLabel,
    String? imageUrl,
  }) async {
    try {
      await _remoteDataSource.dropMessage(
        text: text,
        lat: lat,
        lng: lng,
        locationLabel: locationLabel,
        imageUrl: imageUrl,
      );
    } catch (e) {
      throw Exception('Failed to drop message: ${e.toString()}');
    }
  }
}
