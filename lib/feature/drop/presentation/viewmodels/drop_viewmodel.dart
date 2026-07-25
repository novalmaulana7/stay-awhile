import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stay_awhile_mobile/feature/drop/data/models/drop_model.dart';
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

  DropCategory? _selectedCategory;
  DropCategory? get selectedCategory => _selectedCategory;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  double _lat = 0;
  double _lng = 0;
  String _locationLabel = '';

  bool get canSubmit =>
      _messageText.trim().isNotEmpty && _selectedCategory != null;

  void setMessage(String value) {
    _messageText = value;
    notifyListeners();
  }

  void selectCategory(DropCategory category) {
    _selectedCategory =
        _selectedCategory == category ? null : category;
    notifyListeners();
  }

  void setLocation({required double lat, required double lng, required String label}) {
    _lat = lat;
    _lng = lng;
    _locationLabel = label;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked != null) {
        _selectedImage = File(picked.path);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to pick image';
      notifyListeners();
    }
  }

  void removeImage() {
    _selectedImage = null;
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
        category: _selectedCategory!.name,
        lat: _lat,
        lng: _lng,
        locationLabel: _locationLabel.isNotEmpty ? _locationLabel : null,
        imageUrl: null, // TODO: API — upload image when Firebase Storage is ready
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
