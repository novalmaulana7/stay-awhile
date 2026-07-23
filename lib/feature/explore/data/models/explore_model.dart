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
  });

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
}
