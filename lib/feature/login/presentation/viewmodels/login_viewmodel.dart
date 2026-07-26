import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/feature/login/data/repositories/login_repository.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginViewmodel extends ChangeNotifier {
  final LoginRepository _repository;

  LoginViewmodel({required LoginRepository repository})
      : _repository = repository;

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

  Map<String, String?> _fieldErrors = {};
  Map<String, String?> get fieldErrors => _fieldErrors;

  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  bool get canSubmit => _email.isNotEmpty && _password.isNotEmpty;

  void attachControllers({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    _emailController = emailController;
    _passwordController = passwordController;
    _email = emailController.text;
    _password = passwordController.text;
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    _email = _emailController?.text ?? '';
    _clearFieldError('email');
    notifyListeners();
  }

  void _onPasswordChanged() {
    _password = _passwordController?.text ?? '';
    _clearFieldError('password');
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
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void _clearFieldError(String field) {
    if (_fieldErrors.containsKey(field)) {
      _fieldErrors = Map.from(_fieldErrors)..remove(field);
    }
  }

  bool _validate() {
    _fieldErrors = {};

    if (_email.trim().isEmpty) {
      _fieldErrors['email'] = 'Please enter your email';
    } else if (!_email.contains('@')) {
      _fieldErrors['email'] = 'Email must include @';
    }
    if (_password.isEmpty) {
      _fieldErrors['password'] = 'Please enter your password';
    }

    return _fieldErrors.isEmpty;
  }

  Future<void> login() async {
    if (!_validate()) {
      _status = LoginStatus.error;
      _errorMessage = null;
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
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _repository.createUserDocument(user);
      }
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.loginWithGoogle();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _repository.createUserDocument(user);
      }
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> loginWithApple() async {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.loginWithApple();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _repository.createUserDocument(user);
      }
      _status = LoginStatus.success;
    } catch (e) {
      _status = LoginStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  void onSignUp() {
    // TODO: Navigate to sign up page
  }

  void resetStatus() {
    _status = LoginStatus.initial;
    _errorMessage = null;
    _fieldErrors = {};
    notifyListeners();
  }
}
