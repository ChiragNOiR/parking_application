// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/auth/presentation/login_page.dart';
import 'dart:convert';

import '../../../../core/presentation/theme/app_color.dart';
import '../../../../core/shared/toast.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key, required this.email});
  final String email;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newPassConfirmController =
      TextEditingController();
  bool _isNotValidate = false;
  bool obscureText = true;

  void updatePassword() async {
    if (newPassController.text.isNotEmpty &&
        newPassConfirmController.text.isNotEmpty) {
      var regBody = {
        "email": widget.email,
        "password": newPassController.text,
      };
      try {
        var res = await http.post(
          Uri.parse(updatePass),
          body: jsonEncode(regBody),
          headers: {"Content-Type": "application/json"},
        );
        var jsonResponse = jsonDecode(res.body);
        if (jsonResponse['msg'] == 'Password changed succesfully.') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
          AlertDialogToast.showToast(
              "Password Changed Successfully.", AppColor.connectionLost);
        } else {
          AlertDialogToast.showToast(jsonResponse['msg'], AppColor.danger);
        }
      } catch (e) {
        AlertDialogToast.showToast(
            "Something Went Wrong. \n Please try again Later", AppColor.danger);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'Insert New Password',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: newPassController,
                obscureText: obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 4) {
                    return 'Incorrect Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'New Password',
                    suffix: IconButton(
                      icon: Icon(obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: newPassConfirmController,
                obscureText: obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 4) {
                    return 'Incorrect Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Confirm New Password',
                    suffix: IconButton(
                      icon: Icon(obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FloatingActionButton.extended(
                onPressed: () => {
                  if (_formKey.currentState!.validate())
                    {
                      if (newPassController.text ==
                          newPassConfirmController.text)
                        {updatePassword()}
                      else
                        {
                          AlertDialogToast.showToast(
                              "Passwords do not match", AppColor.danger)
                        }
                    }
                },
                label: Text('Save Password'),
                backgroundColor: AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
