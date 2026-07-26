import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/drop/data/repositories/drop_repository.dart';

enum DropStatus { initial, loading, success, error }

class DropViewmodel extends ChangeNotifier {
  final DropRepository _repository;

  DropViewmodel({required DropRepository repository})
      : _repository = repository;

  DropStatus _status = DropStatus.initial;
  DropStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _messageText = '';
  String get messageText => _messageText;

  double _lat = 0;
  double _lng = 0;
  String _locationLabel = '';

  bool get canSubmit => _messageText.trim().isNotEmpty;

  void setMessage(String value) {
    _messageText = value;
    notifyListeners();
  }

  void setLocation({required double lat, required double lng, required String label}) {
    _lat = lat;
    _lng = lng;
    _locationLabel = label;
    notifyListeners();
  }

  Future<void> dropMessage() async {
    if (!canSubmit) {
      _errorMessage = 'Please fill in the message and select a category';
      notifyListeners();
      return;
    }

    _status = DropStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.dropMessage(
        text: _messageText.trim(),
        lat: _lat,
        lng: _lng,
        locationLabel: _locationLabel.isNotEmpty ? _locationLabel : null,
        imageUrl: null,
      );
      _status = DropStatus.success;
    } catch (e) {
      _status = DropStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  void resetStatus() {
    _status = DropStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
