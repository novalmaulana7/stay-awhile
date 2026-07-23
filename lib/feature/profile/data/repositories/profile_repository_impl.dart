import 'package:stay_awhile_mobile/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';
import 'package:stay_awhile_mobile/feature/profile/data/repositories/profile_repository.dart';

/// Implementation of [ProfileRepository] using remote data source.
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<ProfileModel> fetchProfile() async {
    return _remoteDataSource.fetchProfile();
  }

  @override
  Future<List<DroppedMessageModel>> fetchDroppedMessages() async {
    return _remoteDataSource.fetchDroppedMessages();
  }
}