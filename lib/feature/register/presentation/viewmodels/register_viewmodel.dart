import 'package:firebase_auth/firebase_auth.dart';
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

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool _agreeToTerms = false;
  bool get agreeToTerms => _agreeToTerms;

  Map<String, String?> _fieldErrors = {};
  Map<String, String?> get fieldErrors => _fieldErrors;

  void setFullName(String value) {
    _fullName = value;
    _clearFieldError('fullName');
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    _clearFieldError('email');
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _clearFieldError('password');
    if (_confirmPassword.isNotEmpty && value != _confirmPassword) {
      _fieldErrors['confirmPassword'] = 'Passwords do not match';
    } else {
      _clearFieldError('confirmPassword');
    }
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    if (_password.isNotEmpty && value != _password) {
      _fieldErrors['confirmPassword'] = 'Passwords do not match';
    } else {
      _clearFieldError('confirmPassword');
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void setAgreeToTerms(bool? value) {
    _agreeToTerms = value ?? false;
    _clearFieldError('agreeToTerms');
    notifyListeners();
  }

  bool get canSubmit =>
      _fullName.isNotEmpty &&
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _confirmPassword.isNotEmpty &&
      _password == _confirmPassword &&
      _agreeToTerms;

  void _clearFieldError(String field) {
    if (_fieldErrors.containsKey(field)) {
      _fieldErrors = Map.from(_fieldErrors)..remove(field);
    }
  }

  bool _validate() {
    _fieldErrors = {};

    if (_fullName.trim().isEmpty) {
      _fieldErrors['fullName'] = 'Full name is required';
    }
    if (_email.trim().isEmpty) {
      _fieldErrors['email'] = 'Email is required';
    }
    if (_password.isEmpty) {
      _fieldErrors['password'] = 'Password is required';
    }
    if (_confirmPassword.isEmpty) {
      _fieldErrors['confirmPassword'] = 'Confirm password is required';
    } else if (_password != _confirmPassword) {
      _fieldErrors['confirmPassword'] = 'Passwords do not match';
    }
    if (!_agreeToTerms) {
      _fieldErrors['agreeToTerms'] = 'You must agree to the terms';
    }

    return _fieldErrors.isEmpty;
  }

  Future<void> register() async {
    if (!_validate()) {
      _errorMessage = null;
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
      await FirebaseAuth.instance.signOut();
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
    _fieldErrors = {};
    notifyListeners();
  }
}
