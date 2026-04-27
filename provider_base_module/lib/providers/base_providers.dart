import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  AuthRepository authRepository = AuthRepository(ApiClient());
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set error message
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Helper method to handle async calls safely
  Future<void> execute(Future<void> Function() task) async {
    try {
      setLoading(true);
      clearError();
      await task();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void navigateTo(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    Navigator.pushNamed(
      context,
      route,
      arguments: arguments,
    );
  }

  void navigateAndClearStack(
      BuildContext context,
      String route, {
        Object? arguments,
      }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
          (route) => false,
      arguments: arguments,
    );
  }


  void back(BuildContext context) {
    Navigator.pop(context);
  }


}
