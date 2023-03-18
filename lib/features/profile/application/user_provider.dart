import 'package:flutter/material.dart';

import '../domain/user.dart';

class CurrentUser extends ChangeNotifier {
  User _currentUser = User.empty();

  User get user => _currentUser;

  void setUser(String user) {
    _currentUser = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = User.empty();
    notifyListeners();
  }
}
