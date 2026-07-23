class MapMarker {
  final String id;
  final String message;
  final String icon;
  final double topPercent;
  final double leftPercent;
  final bool isOwn;

  MapMarker({
    required this.id,
    required this.message,
    required this.icon,
    required this.topPercent,
    required this.leftPercent,
    this.isOwn = false,
  });

  factory MapMarker.fromJson(Map<String, dynamic> json) {
    return MapMarker(
      id: json['id'] as String,
      message: json['message'] as String,
      icon: json['icon'] as String,
      topPercent: (json['topPercent'] as num).toDouble(),
      leftPercent: (json['leftPercent'] as num).toDouble(),
      isOwn: json['isOwn'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'icon': icon,
      'topPercent': topPercent,
      'leftPercent': leftPercent,
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
