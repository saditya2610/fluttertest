import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  void loginUser() {
    _isUserLoggedIn = true;
    notifyListeners();
  }

  void logoutUser() {
    _isUserLoggedIn = false;
    notifyListeners();
  }
}
