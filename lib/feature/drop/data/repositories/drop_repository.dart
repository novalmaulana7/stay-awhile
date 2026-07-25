abstract class DropRepository {
  Future<void> dropMessage({
    required String text,
    required String category,
    required double lat,
    required double lng,
    String? locationLabel,
    String? imageUrl,
  });
}
