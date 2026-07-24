import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository.dart';
import 'package:stay_awhile_mobile/utils/services/location_service.dart';

enum ExploreStatus {
  initial,
  loading,
  loaded,
  error,
}

class ExploreViewmodel extends ChangeNotifier {
  final ExploreRepository _repository;
  final LocationService _locationService;

  ExploreViewmodel({
    required ExploreRepository repository,
    LocationService? locationService,
  })  : _repository = repository,
        _locationService = locationService ?? LocationService();

  ExploreStatus _status = ExploreStatus.initial;
  ExploreStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<NearbyMessage> _messages = [];
  List<NearbyMessage> get messages => _messages;

  double _radiusKm = 1.2;
  double get radiusKm => _radiusKm;

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  StreamSubscription<List<NearbyMessage>>? _subscription;

  String get radiusLabel {
    if (_radiusKm < 1) {
      return '${(_radiusKm * 1000).toStringAsFixed(0)}m away';
    }
    return '${_radiusKm.toStringAsFixed(1)}km away';
  }

  Future<void> loadNearbyMessages() async {
    _status = ExploreStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPosition = await _locationService.getCurrentPosition();
      _subscription?.cancel();
      _subscription = _repository
          .getNearbyMessages(
            lat: _currentPosition!.latitude,
            lng: _currentPosition!.longitude,
            radiusKm: _radiusKm,
          )
          .listen(
        (messages) {
          _messages = messages;
          _status = ExploreStatus.loaded;
          notifyListeners();
        },
        onError: (e) {
          _status = ExploreStatus.error;
          _errorMessage = e.toString();
          notifyListeners();
        },
      );
    } catch (e) {
      _status = ExploreStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
    }
  }

  void setRadius(double value) {
    _radiusKm = value;
    notifyListeners();
  }

  Future<void> onRadiusChanged(double value) async {
    _radiusKm = value;
    notifyListeners();
    await loadNearbyMessages();
  }

  void toggleLike(String messageId) {
    final index = _messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;

    final old = _messages[index];
    _messages[index] = NearbyMessage(
      id: old.id,
      authorName: old.authorName,
      authorPhotoUrl: old.authorPhotoUrl,
      text: old.text,
      timeAgo: old.timeAgo,
      distance: old.distance,
      likeCount: old.likeCount + 1,
      commentCount: old.commentCount,
      isPinned: old.isPinned,
      hashtag: old.hashtag,
      isCommunityNote: old.isCommunityNote,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
