enum DropCategory {
  quietSpot,
  recommendation,
  warning,
  story;

  String get label => switch (this) {
        DropCategory.quietSpot => 'Quiet Spot',
        DropCategory.recommendation => 'Recommendation',
        DropCategory.warning => 'Warning',
        DropCategory.story => 'Story',
      };

  String get iconName => switch (this) {
        DropCategory.quietSpot => 'mobile_rotate',
        DropCategory.recommendation => 'recommend',
        DropCategory.warning => 'warning',
        DropCategory.story => 'edit_note',
      };
}

class DropMessageModel {
  final String text;
  final DropCategory category;
  final double lat;
  final double lng;
  final String? locationLabel;
  final String? imageUrl;

  DropMessageModel({
    required this.text,
    required this.category,
    required this.lat,
    required this.lng,
    this.locationLabel,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'category': category.name,
      'lat': lat,
      'lng': lng,
      'locationLabel': locationLabel,
      'imageUrl': imageUrl,
    };
  }

  factory DropMessageModel.fromJson(Map<String, dynamic> json) {
    return DropMessageModel(
      text: json['text'] as String? ?? '',
      category: DropCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => DropCategory.quietSpot,
      ),
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      locationLabel: json['locationLabel'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
