import 'package:flutter/material.dart';
import 'package:parking_app/features/profile/domain/user_model.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';

class UserProvider extends ChangeNotifier {
  late UserService _userService;

  final UserService _service = UserService();
  UserProvider({required UserService userService}) {
    _userService = userService;
  }
  bool isLoading = false;
  List<UserModel> _user = [];
  List<UserModel> get user => _user;

  Future<void> getAllUserDetails() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getUserData();
    _user = response;
    isLoading = false;
    notifyListeners();
  }
}