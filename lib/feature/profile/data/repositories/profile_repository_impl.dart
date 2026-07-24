import 'package:stay_awhile_mobile/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';
import 'package:stay_awhile_mobile/feature/profile/data/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<ProfileModel> fetchProfile() async {
    try {
      return await _remoteDataSource.fetchProfile();
    } catch (e) {
      throw Exception('Failed to load profile: ${e.toString()}');
    }
  }

  @override
  Future<List<DroppedMessageModel>> fetchDroppedMessages() async {
    try {
      return await _remoteDataSource.fetchDroppedMessages();
    } catch (e) {
      throw Exception('Failed to load messages: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      await _remoteDataSource.deleteMessage(messageId);
    } catch (e) {
      throw Exception('Failed to delete message: ${e.toString()}');
    }
  }
}
