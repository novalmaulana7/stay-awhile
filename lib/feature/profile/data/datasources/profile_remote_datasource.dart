import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';

/// Remote data source for profile.
///
/// Currently uses dummy data. Replace with Firestore API calls when ready.
/// TODO: API - Replace dummy data with Firestore queries.
class ProfileRemoteDataSource {
  /// Fetches the current user's profile.
  Future<ProfileModel> fetchProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: API - Replace with Firestore document fetch
    return ProfileModel(
      id: 'user_001',
      name: 'Elena Rivers',
      bio: 'Exploring the quiet corners since 2023',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA_levcW3eMBOXC3K_bkjEierjBocQKfUCXyi2tXHw4fW7jDavJBqRnfOj8U3GTOPaurK-qH8Th9twnyg8uzzNTSimTNXZBzqOVcktbCXlMajwLI5yC8PNbnlpzMGdAN0_2knF_URc9hWp5Jstm5xsspctBmVq8704kSCfLBxx7ySfl5ifi6PkzWhB5aKpT8xZJf_JAg3xS2IUegoGjskq5bUKRzmqLHmQatPR7GD_TQ6PLh0RDsUTJaq1DwwHBnf1SF-w05r8kCwI',
      messagesDropped: 12,
      messagesFound: 48,
      memberSince: '2023',
      appVersion: '2.4.1',
    );
  }

  /// Fetches the list of dropped messages for the current user.
  Future<List<DroppedMessageModel>> fetchDroppedMessages() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: API - Replace with Firestore collection query
    return [
      DroppedMessageModel(
        id: 'msg_001',
        title: 'The Sunlit Bench',
        location: 'Oakwood Park',
        timeAgo: 'Dropped 2 days ago',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDnB4w0e8Nu9H-KrvunSLlI1ljL3ucu_pAFTuciDFbIP5gGQNojCuPKtQ4SRkiwoMkYtiJKhiGpL4CaKKAGVpD40bN-Kdc7qeyZQ1J74MDxCdJTzMkgdu05iAhnqJ4mJgG7EThG5PvpPtpl7RK7VO24GFdz7TzteSjYnrVxxQ7rcs7O89EKDIKbq4nYB4vcaKrqhhLbY0hOq0GXY1mcyFHTrHq0_fslr0dKCmPAPS4436ct3b_MdCfFmgwxwICeu499a69xkC4MdyU',
        previewText: '"Watch how the light hits the pond at 8 AM..."',
      ),
      DroppedMessageModel(
        id: 'msg_002',
        title: 'Quiet Corner Library',
        location: 'Central Library',
        timeAgo: 'Dropped 1 week ago',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBRXt-xNmU59JT5WAHNrPUtwFZwjt__Sj9UEfrQ3KNQdD-m4i1gCTo5xl_DymTW9BiHTkQexioCAkc_5FMeFooOZYyyPtSUzjfv7JosoaKFXEsFmJQNzqasLH2FPj_j807v6JMEAIm1hXMulbgtzgQdtSg9MmFO2h3RJSaTy2wIIWmL9I8NcMR7hah-DzBunFKSWwjBhMA8vyjqtHPG5lQ5IWTm8vC_z5aR6nXh_j1j06tOO8HmqJODyhnk-JFgxbS67fdXqfUXwHo',
        previewText: '"The third shelf in the poetry section has a hidden surprise..."',
      ),
    ];
  }
}