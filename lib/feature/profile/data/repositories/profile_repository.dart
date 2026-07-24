import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> fetchProfile();
  Future<List<DroppedMessageModel>> fetchDroppedMessages();
  Future<void> deleteMessage(String messageId);
}
