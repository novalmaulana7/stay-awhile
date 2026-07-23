import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/login/data/repositories/login_repository.dart';

/// Status for login operations.
enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

/// ViewModel for the login screen.
///
/// Manages form state, validation, and login operations.
/// Extends [ChangeNotifier] to work with the `provider` package.
class LoginViewmodel extends ChangeNotifier {
  final LoginRepository _repository;

  LoginViewmodel({required LoginRepository repository})
      : _repository = repository;

  // ── State ──
  LoginStatus _status = LoginStatus.initial;
  LoginStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  // ── Actions ──

  /// Updates email field value.
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  /// Updates password field value.
  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  /// Toggles password visibility.
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Toggles remember me checkbox.
  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  /// Performs email/password login.
  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _errorMessage = 'Please fill in all fields';
      notifyListeners();
      return;
    }

    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.loginWithEmail(
        email: _email,
        password: _password,
      );
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  /// Performs Google sign-in.
  Future<void> loginWithGoogle() async {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.loginWithGoogle();
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  /// Performs Apple sign-in.
  Future<void> loginWithApple() async {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.loginWithApple();
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  /// Navigates to sign up page.
  void onSignUp() {
    // TODO: Navigate to sign up page
  }

  /// Navigates to forgot password page.
  void onForgotPassword() {
    // TODO: Navigate to forgot password page
  }

  /// Navigates to privacy policy page.
  void onPrivacyPolicy() {
    // TODO: Navigate to privacy policy page
  }

  /// Navigates to terms of service page.
  void onTermsOfService() {
    // TODO: Navigate to terms of service page
  }

  /// Navigates to contact support page.
  void onContactSupport() {
    // TODO: Navigate to contact support page
  }

  /// Resets status to initial after navigation.
  void resetStatus() {
    _status = LoginStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}