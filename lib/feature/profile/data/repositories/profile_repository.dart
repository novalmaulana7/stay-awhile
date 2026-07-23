import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';

/// Abstract repository for profile operations.
abstract class ProfileRepository {
  /// Fetches the current user's profile.
  Future<ProfileModel> fetchProfile();

  /// Fetches the list of dropped messages for the current user.
  Future<List<DroppedMessageModel>> fetchDroppedMessages();
}