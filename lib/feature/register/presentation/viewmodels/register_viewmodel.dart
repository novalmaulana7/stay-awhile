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

  TextEditingController? _fullNameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  void attachControllers({
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) {
    _fullNameController = fullNameController;
    _emailController = emailController;
    _passwordController = passwordController;
    _confirmPasswordController = confirmPasswordController;
    _fullName = fullNameController.text;
    _email = emailController.text;
    _password = passwordController.text;
    _confirmPassword = confirmPasswordController.text;
    fullNameController.addListener(_onFullNameChanged);
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  void _onFullNameChanged() {
    _fullName = _fullNameController?.text ?? '';
    _clearFieldError('fullName');
    notifyListeners();
  }

  void _onEmailChanged() {
    _email = _emailController?.text ?? '';
    _clearFieldError('email');
    notifyListeners();
  }

  void _onPasswordChanged() {
    _password = _passwordController?.text ?? '';
    _clearFieldError('password');
    if (_confirmPassword.isNotEmpty && _password != _confirmPassword) {
      _fieldErrors['confirmPassword'] = "Passwords don't match";
    } else {
      _clearFieldError('confirmPassword');
    }
    notifyListeners();
  }

  void _onConfirmPasswordChanged() {
    _confirmPassword = _confirmPasswordController?.text ?? '';
    if (_password.isNotEmpty && _confirmPassword != _password) {
      _fieldErrors['confirmPassword'] = "Passwords don't match";
    } else {
      _clearFieldError('confirmPassword');
    }
    notifyListeners();
  }

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
      _fieldErrors['confirmPassword'] = "Passwords don't match";
    } else {
      _clearFieldError('confirmPassword');
    }
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    if (_password.isNotEmpty && value != _password) {
      _fieldErrors['confirmPassword'] = "Passwords don't match";
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
      _fieldErrors['fullName'] = 'Please enter your full name';
    }
    if (_email.trim().isEmpty) {
      _fieldErrors['email'] = 'Please enter your email';
    } else if (!_email.contains('@')) {
      _fieldErrors['email'] = 'Email must include @';
    }
    if (_password.isEmpty) {
      _fieldErrors['password'] = 'Please enter a password';
    }
    if (_confirmPassword.isEmpty) {
      _fieldErrors['confirmPassword'] = 'Please confirm your password';
    } else if (_password != _confirmPassword) {
      _fieldErrors['confirmPassword'] = 'Passwords don\'t match';
    }
    if (!_agreeToTerms) {
      _fieldErrors['agreeToTerms'] = 'Please agree to the terms';
    }

    return _fieldErrors.isEmpty;
  }

  Future<void> register() async {
    if (!_validate()) {
      _status = RegisterStatus.error;
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
