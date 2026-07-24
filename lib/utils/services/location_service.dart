import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  Future<String> reverseGeocode(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isEmpty) return 'Unknown location';

      final place = placemarks.first;
      final parts = <String>[
        if (place.name != null && place.name!.isNotEmpty) place.name!,
        if (place.subLocality != null && place.subLocality!.isNotEmpty)
          place.subLocality!,
        if (place.locality != null && place.locality!.isNotEmpty)
          place.locality!,
      ];
      return parts.isNotEmpty ? parts.join(', ') : 'Unknown location';
    } catch (_) {
      return 'Unknown location';
    }
  }
}
