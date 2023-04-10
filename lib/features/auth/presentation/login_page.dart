import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/features/auth/presentation/widgets/forgot_pass.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/auth/presentation/create_account_page.dart';
import 'package:parking_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:parking_app/features/auth/presentation/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;
  final UserService userService = UserService();

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
        child: Form(
          key: _formKey,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Check if you are using correct email format';
                        }
                        if (!value.contains('gmail') ||
                            !value.endsWith('.com')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 240,
                    left: 20,
                    child: AuthTextField(
                      obscureText: true,
                      controller: passwordController,
                      text: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 4) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 210,
                    left: 80,
                    child: AuthButton(
                      text: 'LOGIN',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser();
                        }
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPass(),
                                ),
                              ),
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
      ),
    );
  }
}
