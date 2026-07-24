import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/register/data/repositories/register_repository.dart';

enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterViewmodel extends ChangeNotifier {
  final RegisterRepository _repository;

  RegisterViewmodel({required RegisterRepository repository})
      : _repository = repository;

  RegisterStatus _status = RegisterStatus.initial;
  RegisterStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _fullName = '';
  String get fullName => _fullName;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _agreeToTerms = false;
  bool get agreeToTerms => _agreeToTerms;

  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setAgreeToTerms(bool? value) {
    _agreeToTerms = value ?? false;
    notifyListeners();
  }

  bool get canSubmit =>
      _fullName.isNotEmpty &&
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _agreeToTerms;

  Future<void> register() async {
    if (!canSubmit) {
      _errorMessage = 'Please fill all fields and agree to the terms';
      notifyListeners();
      return;
    }

    _status = RegisterStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.registerWithEmail(
        fullName: _fullName,
        email: _email,
        password: _password,
      );
      _status = RegisterStatus.success;
    } catch (e) {
      _status = RegisterStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> registerWithGoogle() async {
    _status = RegisterStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.registerWithGoogle();
      _status = RegisterStatus.success;
    } catch (e) {
      _status = RegisterStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> registerWithApple() async {
    _status = RegisterStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.registerWithApple();
      _status = RegisterStatus.success;
    } catch (e) {
      _status = RegisterStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  void resetStatus() {
    _status = RegisterStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
