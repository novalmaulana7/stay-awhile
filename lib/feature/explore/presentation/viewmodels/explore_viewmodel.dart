import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/explore/data/models/explore_model.dart';
import 'package:stay_awhile_mobile/feature/explore/data/repositories/explore_repository.dart';

enum ExploreStatus {
  initial,
  loading,
  loaded,
  error,
}

class ExploreViewmodel extends ChangeNotifier {
  final ExploreRepository _repository;

  ExploreViewmodel({required ExploreRepository repository})
      : _repository = repository;

  // ── State ──
  ExploreStatus _status = ExploreStatus.initial;
  ExploreStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<NearbyMessage> _messages = [];
  List<NearbyMessage> get messages => _messages;

  double _radiusKm = 1.2;
  double get radiusKm => _radiusKm;

  String get radiusLabel {
    if (_radiusKm < 1) {
      return '${(_radiusKm * 1000).toStringAsFixed(0)}m away';
    }
    return '${_radiusKm.toStringAsFixed(1)}km away';
  }

  // ── Actions ──

  Future<void> loadNearbyMessages() async {
    _status = ExploreStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _messages = await _repository.getNearbyMessages(radiusKm: _radiusKm);
      _status = ExploreStatus.loaded;
    } catch (e) {
      _status = ExploreStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
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
    // TODO: API - Toggle like via Firestore
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
}
