import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:parking_app/features/auth/presentation/login_page.dart';
import 'package:parking_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:parking_app/features/auth/presentation/widgets/text_field.dart';

import '../../../core/shared/config.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController createUsernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isNotValidate = false;

  // signUp() {
  //   print('Test');
  //   // String uid = _conUserId.text;
  //   String uName = fullNameController.text;
  //   String uEmail = createUsernameController.text;
  //   String uPassword = passwordController.text;
  //   String uConfirmPassword = confirmPasswordController.text;

  //   if (_formKey.currentState!.validate()) {
  //     if (uPassword != uConfirmPassword) {
  //       alertDialog(context, 'Password Mismatched! Please Try Again');
  //     } else {
  //       _formKey.currentState!.save();
  //     }
  //   }
  // }
  void registerUser() async {
    if (createUsernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var regBody = {
        "email": createUsernameController.text,
        "password": passwordController.text,
      };
      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['success']);

      if (jsonResponse['status']) {
        Navigator.pop(context);
        // alertDialog(context, 'Registered Successfully');
      } else {
        // alertDialog(context, 'Something went wrong');
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 700,
                  width: double.infinity,
                ),
                SizedBox(
                  width: 400,
                  child: Image.asset('assets/images/create.png'),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    'Create\nAccount :)',
                    style: AppStyle.loginpageh1,
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 20,
                  child: AuthTextField(
                    text: 'Full Name',
                    keyboardType: TextInputType.name,
                    controller: fullNameController,
                    errorText:
                        _isNotValidate ? "Enter Proper Information" : null,
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 20,
                  child: AuthTextField(
                    text: 'Create Username',
                    keyboardType: TextInputType.emailAddress,
                    controller: createUsernameController,
                    errorText:
                        _isNotValidate ? "Enter Proper Information" : null,
                  ),
                ),
                Positioned(
                  top: 370,
                  left: 20,
                  child: AuthTextField(
                    text: 'Create Password',
                    // keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passwordController,
                    errorText:
                        _isNotValidate ? "Enter Proper Information" : null,
                  ),
                ),
                Positioned(
                  top: 470,
                  left: 20,
                  child: AuthTextField(
                    text: 'Confirm Password',
                    // keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: confirmPasswordController,
                    errorText:
                        _isNotValidate ? "Enter Proper Information" : null,
                  ),
                ),
                Positioned(
                  bottom: 75,
                  child: AuthButton(
                    text: 'Sign Up',
                    onTap: () => {registerUser()},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
