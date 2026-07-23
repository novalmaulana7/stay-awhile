import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/splash/data/repositories/splash_repository.dart';

/// ViewModel for the splash screen.
///
/// Checks authentication state and determines navigation target.
class SplashViewmodel extends ChangeNotifier {
  final SplashRepository _repository;

  SplashViewmodel({required SplashRepository repository})
      : _repository = repository;

  /// Duration to show splash screen before navigating.
  static const Duration splashDuration = Duration(seconds: 3);

  /// Checks if user is logged in and returns the appropriate route.
  String getInitialRoute() {
    if (_repository.isUserLoggedIn()) {
      return '/dashboard';
    }
    return '/login';
  }
}
