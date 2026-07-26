class DropMessageModel {
  final String text;
  final double lat;
  final double lng;
  final String? locationLabel;
  final String? imageUrl;

  DropMessageModel({
    required this.text,
    required this.lat,
    required this.lng,
    this.locationLabel,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'lat': lat,
      'lng': lng,
      'locationLabel': locationLabel,
      'imageUrl': imageUrl,
    };
  }

  factory DropMessageModel.fromJson(Map<String, dynamic> json) {
    return DropMessageModel(
      text: json['text'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      locationLabel: json['locationLabel'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
