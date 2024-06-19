import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  String? _error;
  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _userHasBeenLogined = false;
  bool get userHasBeenLogined => _userHasBeenLogined;

  Future<void> onLoginClick({
    required String login,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _verifyCredentials(login: login, password: password);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: login,
        password: password,
      );

      _userHasBeenLogined = true;
    } catch (exception) {
      if (exception is _WrongCredentialsException) {
        _error = 'incorrect  credentials';
      } else {
        _error = 'Something went wrong';
      }
    } finally {
      _isLoading = false;
    }

    notifyListeners();
  }

  void _verifyCredentials({
    required String login,
    required String password,
  }) {
    if (login.isEmpty || password.isEmpty) {
      throw _WrongCredentialsException();
    }
  }
}

class _WrongCredentialsException implements Exception {}
