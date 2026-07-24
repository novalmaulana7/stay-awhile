import 'package:cloud_firestore/cloud_firestore.dart';

class NearbyMessage {
  final String id;
  final String authorName;
  final String? authorPhotoUrl;
  final String text;
  final String timeAgo;
  final String distance;
  final int likeCount;
  final int commentCount;
  final bool isPinned;
  final String? hashtag;
  final bool isCommunityNote;
  final DateTime? createdAt;

  NearbyMessage({
    required this.id,
    required this.authorName,
    this.authorPhotoUrl,
    required this.text,
    required this.timeAgo,
    required this.distance,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isPinned = false,
    this.hashtag,
    this.isCommunityNote = false,
    this.createdAt,
  });

  factory NearbyMessage.fromFirestore(
    Map<String, dynamic> data,
    String docId, {
    double? distanceKm,
  }) {
    return NearbyMessage(
      id: docId,
      authorName: data['authorName'] as String? ?? 'Anonymous',
      authorPhotoUrl: data['authorPhotoUrl'] as String?,
      text: data['text'] as String? ?? '',
      timeAgo: _formatTimeAgo(data['createdAt'] as Timestamp?),
      distance: distanceKm != null
          ? '${distanceKm.toStringAsFixed(1)}km'
          : 'nearby',
      likeCount: (data['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (data['commentCount'] as num?)?.toInt() ?? 0,
      isPinned: data['isPinned'] as bool? ?? false,
      hashtag: data['hashtag'] as String?,
      isCommunityNote: data['isCommunityNote'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory NearbyMessage.fromJson(Map<String, dynamic> json) {
    return NearbyMessage(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorPhotoUrl: json['authorPhotoUrl'] as String?,
      text: json['text'] as String,
      timeAgo: json['timeAgo'] as String,
      distance: json['distance'] as String,
      likeCount: json['likeCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      isPinned: json['isPinned'] as bool? ?? false,
      hashtag: json['hashtag'] as String?,
      isCommunityNote: json['isCommunityNote'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorPhotoUrl': authorPhotoUrl,
      'text': text,
      'timeAgo': timeAgo,
      'distance': distance,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'isPinned': isPinned,
      'hashtag': hashtag,
      'isCommunityNote': isCommunityNote,
    };
  }

  static String _formatTimeAgo(Timestamp? timestamp) {
    if (timestamp == null) return 'just now';
    final diff = DateTime.now().difference(timestamp.toDate());
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${(diff.inDays / 7).floor()} weeks ago';
  }
}
