import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';

class DashboardRemoteDataSource {
  Future<List<MapMarker>> getMapMarkers() async {
    // TODO: API - Replace with actual Firestore/REST call
    return [
      MapMarker(
        id: '1',
        message: 'Found a quiet bench...',
        icon: 'park',
        topPercent: 20,
        leftPercent: 30,
      ),
      MapMarker(
        id: '2',
        message: 'Great morning light here.',
        icon: 'coffee',
        topPercent: 55,
        leftPercent: 65,
      ),
      MapMarker(
        id: '3',
        message: 'Look up at the oak!',
        icon: 'camera',
        topPercent: 15,
        leftPercent: 75,
      ),
    ];
  }

  Future<LocationInfo> getCurrentLocation() async {
    // TODO: API - Replace with actual geolocation + Firestore lookup
    return LocationInfo(
      name: 'Golden Gate Park',
      subtitle: 'Inner Sunset, San Francisco',
      description: '42 neighbors have left notes here today.',
      neighborCount: 42,
      avatarUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDez_PBlMW8no9EX4YqmuzSQQ7i9THk_-pPdTBojBz0ur-qrc1nlhtwCaGfSbdeBqzliYJdJPrmKNLgbhEVbkJBhYipjb_Qw7luBNruYM1-0GclyDCNvsi-pbR6l1KO7S85oww8NQgNTBxbd2cRyq727vxBqw3Ex2nETk9BnTDv_1HQ_tnNvZ_3MHWughNt8a8r8brkInrCQrXI-WkiBwFf7OYVldztUtj-PoQEUOwg0AWGm34tsdX_Equ-e9IQ2vSpx3doUWK7tnI',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAi3i_M5l3zB07UrNWEDaPVNhTJdVk3BVU6noWIAF9HXR0OuPLJT6qev4y65PsVNjPKy32iugsq0m1aeijYXslzMtTPq41CTGlu-R4bcRMd8sHRvVKQmTMqoN0DWLXCw4R0I74AS8ri-_b-9YXSk50YZxDZyO5LnYgH6FyRpzOgCO3bjz17a023j67rxpTuY5cUIjz9JJV1z_sktTjFNuE2O3LKOGcPqPHmk-9RuNqn2k9CNUcxbgb4yD-wkyDKQhOsBccyEJnEZDs',
      ],
    );
  }

  Future<void> dropMessage({
    required String message,
    required String icon,
  }) async {
    // TODO: API - Replace with actual Firestore write
  }
}
