// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/presentation/bottom_nav.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:parking_app/features/admin/presentation/admin_home.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/shared/error_handling.dart';

class UserService {
  Future<void> loginUser({
    required BuildContext context,
    required String userEmail,
    required String userPassword,
    bool toast = true,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/login'),
        body: jsonEncode({
          'email': userEmail,
          'password': userPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<CurrentUser>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          final user = context.read<CurrentUser>().user;

          if (user.role == "admin") {
            AlertDialogToast.showToast(
                "Logging ${Provider.of<CurrentUser>(context, listen: false).user.fullName}",
                AppColor.primary);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ));
          } else {
            AlertDialogToast.showToast(
                "Logging ${Provider.of<CurrentUser>(context, listen: false).user.fullName}",
                AppColor.primary);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBar(),
              ),
            );
          }
        },
      );
    } catch (e) {
      AlertDialogToast.showToast("Something Went Wrong!! ", AppColor.danger);
    }
  }

  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      print(token);

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$url/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$url/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<CurrentUser>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      AlertDialogToast.showToast("Something Went Wrong!!", AppColor.danger);
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove('x-auth-token');
      return;
    } catch (e) {
      AlertDialogToast.showToast("Something Went Wrong!!", AppColor.danger);
    }
  }
}
