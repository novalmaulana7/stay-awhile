import 'package:stay_awhile_mobile/feature/splash/data/datasources/splash_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/splash/data/repositories/splash_repository.dart';

/// Implementation of SplashRepository.
class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _remoteDataSource;

  SplashRepositoryImpl({
    required SplashRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  bool isUserLoggedIn() {
    // TODO: API - Replace with proper session/token check if needed
    return _remoteDataSource.getCurrentUser() != null;
  }
}
