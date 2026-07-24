import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory ProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    final joinDate = (data['joinDate'] as Timestamp?)?.toDate();
    return ProfileModel(
      id: doc.id,
      name: data['displayName'] as String? ?? '',
      bio: data['bio'] as String? ?? '',
      avatarUrl: data['photoUrl'] as String? ?? '',
      messagesDropped: (data['messagesDropped'] as num?)?.toInt() ?? 0,
      messagesFound: (data['messagesFound'] as num?)?.toInt() ?? 0,
      memberSince: joinDate != null ? '${joinDate.year}' : '',
      appVersion: '1.0.0',
    );
  }

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

  factory DroppedMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
    final timeAgo = createdAt != null ? _formatTimeAgo(createdAt) : 'just now';
    return DroppedMessageModel(
      id: doc.id,
      title: data['text'] as String? ?? '',
      location: data['locationLabel'] as String? ?? 'Unknown location',
      timeAgo: 'Dropped $timeAgo',
      imageUrl: data['imageUrl'] as String? ?? '',
      previewText: '"${data['text'] as String? ?? ''}"',
    );
  }

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

  static String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} weeks ago';
    return '${(diff.inDays / 30).floor()} months ago';
  }
}
