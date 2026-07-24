import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/repositories/dashboard_repository.dart';
import 'package:stay_awhile_mobile/utils/services/location_service.dart';

enum DashboardStatus {
  initial,
  loading,
  loaded,
  error,
}

class DashboardViewmodel extends ChangeNotifier {
  final DashboardRepository _repository;
  final LocationService _locationService;

  DashboardViewmodel({
    required DashboardRepository repository,
    LocationService? locationService,
  })  : _repository = repository,
        _locationService = locationService ?? LocationService();

  DashboardStatus _status = DashboardStatus.initial;
  DashboardStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MapMarker> _markers = [];
  List<MapMarker> get markers => _markers;

  LocationInfo? _locationInfo;
  LocationInfo? get locationInfo => _locationInfo;

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  String? _currentAddress;
  String? get currentAddress => _currentAddress;

  bool _showDropDialog = false;
  bool get showDropDialog => _showDropDialog;

  Future<void> loadDashboard() async {
    _status = DashboardStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPosition = await _locationService.getCurrentPosition();
      _currentAddress = await _locationService.reverseGeocode(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      final results = await Future.wait([
        _repository.getMapMarkers(),
        _repository.getCurrentLocation(),
      ]);
      _markers = results[0] as List<MapMarker>;
      _locationInfo = results[1] as LocationInfo;
      _status = DashboardStatus.loaded;
    } catch (e) {
      _status = DashboardStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  void toggleDropDialog() {
    _showDropDialog = !_showDropDialog;
    notifyListeners();
  }

  void closeDropDialog() {
    _showDropDialog = false;
    notifyListeners();
  }

  Future<void> dropMessage({
    required String text,
  }) async {
    if (_currentPosition == null) {
      _errorMessage = 'Location not available';
      notifyListeners();
      return;
    }

    try {
      await _repository.dropMessage(
        text: text,
        lat: _currentPosition!.latitude,
        lng: _currentPosition!.longitude,
        locationLabel: _currentAddress,
      );
      _showDropDialog = false;
      await loadDashboard();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
    }
  }
}
