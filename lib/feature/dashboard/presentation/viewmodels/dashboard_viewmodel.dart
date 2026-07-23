import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/models/dashboard_model.dart';
import 'package:stay_awhile_mobile/feature/dashboard/data/repositories/dashboard_repository.dart';

enum DashboardStatus {
  initial,
  loading,
  loaded,
  error,
}

class DashboardViewmodel extends ChangeNotifier {
  final DashboardRepository _repository;

  DashboardViewmodel({required DashboardRepository repository})
      : _repository = repository;

  // ── State ──
  DashboardStatus _status = DashboardStatus.initial;
  DashboardStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MapMarker> _markers = [];
  List<MapMarker> get markers => _markers;

  LocationInfo? _locationInfo;
  LocationInfo? get locationInfo => _locationInfo;

  bool _showDropDialog = false;
  bool get showDropDialog => _showDropDialog;

  // ── Actions ──

  Future<void> loadDashboard() async {
    _status = DashboardStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
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
    required String message,
    required String icon,
  }) async {
    try {
      await _repository.dropMessage(message: message, icon: icon);
      _showDropDialog = false;
      await loadDashboard();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
    }
  }
}
