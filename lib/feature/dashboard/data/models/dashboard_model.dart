class DroppedMessage {
  final String id;
  final String authorId;
  final String authorName;
  final String text;
  final double lat;
  final double lng;
  final String? locationLabel;
  final int likeCount;
  final String? imageUrl;

  DroppedMessage({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.text,
    required this.lat,
    required this.lng,
    this.locationLabel,
    this.likeCount = 0,
    this.imageUrl,
  });

  factory DroppedMessage.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    final geo = data['geo'] as Map<String, dynamic>?;
    final geopoint = geo?['geopoint'] as dynamic;
    return DroppedMessage(
      id: docId,
      authorId: data['authorId'] as String? ?? '',
      authorName: data['authorName'] as String? ?? '',
      text: data['text'] as String? ?? '',
      lat: (geopoint?.latitude as num?)?.toDouble() ?? 0,
      lng: (geopoint?.longitude as num?)?.toDouble() ?? 0,
      locationLabel: data['locationLabel'] as String?,
      likeCount: (data['likeCount'] as num?)?.toInt() ?? 0,
      imageUrl: data['imageUrl'] as String?,
    );
  }
}

class MapMarker {
  final String id;
  final String message;
  final String icon;
  final double lat;
  final double lng;
  final bool isOwn;

  MapMarker({
    required this.id,
    required this.message,
    required this.icon,
    required this.lat,
    required this.lng,
    this.isOwn = false,
  });

  factory MapMarker.fromJson(Map<String, dynamic> json) {
    return MapMarker(
      id: json['id'] as String,
      message: json['message'] as String,
      icon: json['icon'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      isOwn: json['isOwn'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'icon': icon,
      'lat': lat,
      'lng': lng,
      'isOwn': isOwn,
    };
  }
}

class LocationInfo {
  final String name;
  final String subtitle;
  final String description;
  final int neighborCount;
  final List<String> avatarUrls;

  LocationInfo({
    required this.name,
    required this.subtitle,
    required this.description,
    required this.neighborCount,
    required this.avatarUrls,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      neighborCount: json['neighborCount'] as int,
      avatarUrls: (json['avatarUrls'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subtitle': subtitle,
      'description': description,
      'neighborCount': neighborCount,
      'avatarUrls': avatarUrls,
    };
  }
}
