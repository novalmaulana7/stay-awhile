import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';

abstract class DashboardRepository {
  Future<List<MapMarker>> getMapMarkers();
  Future<LocationInfo> getCurrentLocation();
  Future<void> dropMessage({
    required String message,
    required String icon,
  });
}
