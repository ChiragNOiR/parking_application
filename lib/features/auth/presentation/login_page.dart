import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/features/profile/domain/user.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:parking_app/core/presentation/bottom_nav.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/auth/presentation/create_account_page.dart';
import 'package:parking_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:parking_app/features/auth/presentation/widgets/text_field.dart';
import 'package:parking_app/features/home/presentation/home_page.dart';

import '../../../core/shared/config.dart';
import '../../profile/application/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _isNotValidate = false;
  late SharedPreferences prefs;
  final UserService userService = UserService();
  @override
  // void initState() {
  //   initSharedPref();
  //   super.initState();
  // }

  // void initSharedPref() async {
  //   // SharedPreferences.setMockInitialValues({});
  //   prefs = await SharedPreferences.getInstance();
  // }

  // void loginUser() async {
  //   if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
  //     var regBody = {
  //       "email": nameController.text,
  //       "password": passwordController.text,
  //     };

  //     var response = await http.post(
  //       Uri.parse(login),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(regBody),
  //     );
  //     var jsonResponse = jsonDecode(response.body);
  //     if (jsonResponse['status']) {
  //       var myToken = jsonResponse['token'];
  //       prefs.setString('token', myToken);

  //       var userProvider = Provider.of<CurrentUser>(context, listen: false);
  //       userProvider.setUser(jsonResponse);

  //       // ignore: use_build_context_synchronously
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(token: myToken),
  //         ),
  //       );
  //     } else {
  //       print('Something went wrong');
  //     }
  //   }
  // }
  void loginUser() {
    userService.loginUser(
        context: context,
        userEmail: nameController.text,
        userPassword: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text.rich(
                TextSpan(
                  text: 'Welcome Back!\n',
                  style: AppStyle.loginpageh1,
                  children: <InlineSpan>[
                    TextSpan(
                        text: 'Enter Your Username & Password',
                        style: AppStyle.loginpageh2)
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: 624.9,
                  color: Colors.white,
                ),
                Positioned(
                  height: 600,
                  bottom: 0,
                  child: Image.asset('assets/images/Union.png'),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: AuthTextField(
                    controller: nameController,
                    text: 'Username',
                  ),
                ),
                Positioned(
                  top: 240,
                  left: 20,
                  child: AuthTextField(
                    obscureText: true,
                    controller: passwordController,
                    text: 'Password',
                  ),
                ),
                Positioned(
                  bottom: 210,
                  left: 80,
                  child: AuthButton(
                    text: 'LOGIN',
                    onTap: () {
                      loginUser();
                    },
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 110,
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'Forgotten Password?\n',
                      style: AppStyle.loginpageh3,
                      children: <InlineSpan>[
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                        TextSpan(
                          text: 'OR\n',
                          style: AppStyle.loginpageh3,
                        ),
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                        TextSpan(
                          text: 'Create a New Account',
                          style: AppStyle.loginpageh3,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccountPage(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
