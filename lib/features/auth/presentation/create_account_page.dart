import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:parking_app/features/auth/presentation/widgets/text_field.dart';

import '../../../core/shared/config.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool _isNotValidate = false;

  // signUp() {
  //   print('Test');
  //   // String uid = _conUserId.text;
  //   String uName = fullNameController.text;
  //   String uEmail = emailController.text;
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
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      var regBody = {
        "fullName": fullNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "contact": contactController.text,
        "address": addressController.text,
      };
      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['success']);

      if (jsonResponse['status']) {
        // ignore: use_build_context_synchronously
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
        child: Form(
          key: _formKey,
          child: Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 850,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 40,
                    child: SizedBox(
                      width: 400,
                      // height: 400,
                      child: Image.asset('assets/images/create.png'),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      'Create\nAccount :)',
                      style: AppStyle.loginpageh1,
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 20,
                    child: AuthTextField(
                      text: 'Full Name',
                      keyboardType: TextInputType.name,
                      controller: fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full Name is required';
                        }

                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 220,
                    left: 20,
                    child: AuthTextField(
                      text: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@') || !value.contains('.com')) {
                          return 'Invalid email format! Please use google mail only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 330,
                    left: 20,
                    child: AuthTextField(
                      text: 'Create Password',
                      // keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      icon: Icons.visibility,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 430,
                    left: 20,
                    child: AuthTextField(
                      text: 'Confirm Password',
                      // keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      icon: Icons.visibility,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 540,
                    left: 20,
                    child: AuthTextField(
                      text: 'Contact Number',
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Contact details is required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Contact details should contain only numbers';
                        }
                        if (value.length != 10) {
                          return 'Contact details should contain exactly 10 numbers';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    top: 650,
                    left: 20,
                    child: AuthTextField(
                      text: 'Address',
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address is required';
                        }

                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: AuthButton(
                      text: 'Sign Up',
                      onTap: () => {
                        if (_formKey.currentState!.validate()) {registerUser()}
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
