import 'package:flutter/foundation.dart';

/// Holds user session and auth state
class UserSession extends ChangeNotifier {
  static final UserSession _instance = UserSession._internal();
  factory UserSession() => _instance;
  UserSession._internal();

  bool _isLoggedIn = false;
  String _userName = 'Explorer';
  String _email = '';
  String _destination = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get email => _email;
  String get destination => _destination;

  String get avatarInitial =>
      _userName.isNotEmpty ? _userName[0].toUpperCase() : 'E';

  void login({required String email, String? customName}) {
    _isLoggedIn = true;
    _email = email;
    if (customName != null && customName.trim().isNotEmpty) {
      _userName = customName.trim();
    } else {
      final namePart = email.split('@').first;
      if (namePart.isNotEmpty) {
        _userName = namePart[0].toUpperCase() + namePart.substring(1);
      } else {
        _userName = 'Explorer';
      }
    }
    notifyListeners();
  }

  void register({
    required String name,
    required String email,
    required String destination,
  }) {
    _isLoggedIn = true;
    _userName = name.trim().split(' ').first;
    if (_userName.isNotEmpty) {
      _userName = _userName[0].toUpperCase() + _userName.substring(1);
    }
    _email = email;
    _destination = destination;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = 'Explorer';
    _email = '';
    _destination = '';
    notifyListeners();
  }
}
