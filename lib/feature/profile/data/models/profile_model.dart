class ProfileModel {
  final String id;
  final String name;
  final String bio;
  final String avatarUrl;
  final int messagesDropped;
  final int messagesFound;
  final String memberSince;
  final String appVersion;

  ProfileModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.messagesDropped,
    required this.messagesFound,
    required this.memberSince,
    required this.appVersion,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      messagesDropped: json['messages_dropped'] as int? ?? 0,
      messagesFound: json['messages_found'] as int? ?? 0,
      memberSince: json['member_since'] as String? ?? '',
      appVersion: json['app_version'] as String? ?? '1.0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'avatar_url': avatarUrl,
      'messages_dropped': messagesDropped,
      'messages_found': messagesFound,
      'member_since': memberSince,
      'app_version': appVersion,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? bio,
    String? avatarUrl,
    int? messagesDropped,
    int? messagesFound,
    String? memberSince,
    String? appVersion,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      messagesDropped: messagesDropped ?? this.messagesDropped,
      messagesFound: messagesFound ?? this.messagesFound,
      memberSince: memberSince ?? this.memberSince,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}

/// Model for a dropped message item shown in the profile list.
class DroppedMessageModel {
  final String id;
  final String title;
  final String location;
  final String timeAgo;
  final String imageUrl;
  final String previewText;

  DroppedMessageModel({
    required this.id,
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.imageUrl,
    required this.previewText,
  });

  factory DroppedMessageModel.fromJson(Map<String, dynamic> json) {
    return DroppedMessageModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      timeAgo: json['time_ago'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      previewText: json['preview_text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'time_ago': timeAgo,
      'image_url': imageUrl,
      'preview_text': previewText,
    };
  }
}