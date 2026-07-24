import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';

abstract class DashboardRepository {
  Future<List<MapMarker>> getMapMarkers();
  Future<LocationInfo> getCurrentLocation();
  Future<void> dropMessage({
    required String text,
    required double lat,
    required double lng,
    String? locationLabel,
  });
}
