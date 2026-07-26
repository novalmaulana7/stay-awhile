import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum LocationPermissionStatus {
  initial,
  requesting,
  granted,
  denied,
  deniedForever,
}

class SplashViewmodel extends ChangeNotifier {
  SplashViewmodel();

  static const Duration splashDuration = Duration(seconds: 3);

  LocationPermissionStatus _permissionStatus = LocationPermissionStatus.initial;
  LocationPermissionStatus get permissionStatus => _permissionStatus;

  Future<void> requestLocationPermission() async {
    _permissionStatus = LocationPermissionStatus.requesting;
    await Future.microtask(() => notifyListeners());

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _permissionStatus = LocationPermissionStatus.denied;
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      _permissionStatus = LocationPermissionStatus.denied;
    } else if (permission == LocationPermission.deniedForever) {
      _permissionStatus = LocationPermissionStatus.deniedForever;
    } else {
      _permissionStatus = LocationPermissionStatus.granted;
    }

    notifyListeners();
  }
}
