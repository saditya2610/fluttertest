import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _username = '';
  String _level = '';
  late String _userRole; // Tambahkan _userRole

  String get username => _username;
  String get level => _level;
  String get userRole => _userRole; // Getter untuk mendapatkan _userRole

  bool get isUserLoggedIn => _username.isNotEmpty;

  void loginUser(String username, String level) {
    _username = username;
    _level = level;
    notifyListeners();
  }

  void logoutUser() {
    _username = '';
    _level = '';
    _userRole = ''; // Kosongkan _userRole saat logout
    notifyListeners();
  }

  bool get isAdmin => _level == 'admin';
  bool get isTendik => _level == 'tendik';

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }
}
