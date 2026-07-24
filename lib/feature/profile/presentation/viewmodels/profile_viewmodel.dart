import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';
import 'package:stay_awhile_mobile/feature/profile/data/repositories/profile_repository.dart';

/// Possible states for the profile screen.
enum ProfileStatus { initial, loading, loaded, error }

/// ViewModel for the profile screen.
///
/// Extends [ChangeNotifier] to work with the `provider` package.
/// Manages loading profile data and dropped messages.
/// All UI actions and callbacks are handled here (Rule 10).
class ProfileViewmodel extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileViewmodel({required ProfileRepository repository})
      : _repository = repository;

  // ── State ──
  ProfileStatus _status = ProfileStatus.initial;
  ProfileStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  List<DroppedMessageModel> _droppedMessages = [];
  List<DroppedMessageModel> get droppedMessages => _droppedMessages;

  // ── Actions ──

  /// Loads the profile and dropped messages.
  Future<void> loadProfile() async {
    _status = ProfileStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.fetchProfile(),
        _repository.fetchDroppedMessages(),
      ]);

      _profile = results[0] as ProfileModel;
      _droppedMessages = results[1] as List<DroppedMessageModel>;
      _status = ProfileStatus.loaded;
    } catch (e) {
      _status = ProfileStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await _repository.deleteMessage(messageId);
      _droppedMessages = _droppedMessages.where((m) => m.id != messageId).toList();
      if (_profile != null) {
        _profile = _profile!.copyWith(
          messagesDropped: _profile!.messagesDropped - 1,
        );
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Shows a confirmation dialog and deletes the message if confirmed.
  Future<void> confirmAndDeleteMessage(
    BuildContext context,
    String messageId,
  ) async {
    final message = _droppedMessages.firstWhere((m) => m.id == messageId);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove memory?'),
        content: Text('Are you sure you want to remove "${message.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await deleteMessage(messageId);
    }
  }

  // ── Navigation actions (TODOs) ──

  void onEditProfile() {
    // TODO: Navigate to edit profile page
  }

  void onNotifications() {
    // TODO: Navigate to notifications page
  }

  void onViewAllMessages() {
    // TODO: Navigate to all messages page
  }

  void onEditMessage(String messageId) {
    // TODO: Navigate to edit message page with messageId
  }

  void onSettingsNotifications() {
    // TODO: Navigate to notification settings page
  }

  void onSettingsPrivacy() {
    // TODO: Navigate to privacy settings page
  }

  void onSettingsLanguage() {
    // TODO: Navigate to language settings page
  }

  void onSettingsSupport() {
    // TODO: Navigate to support center page
  }

  Future<void> onLogout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}