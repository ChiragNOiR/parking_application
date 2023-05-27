import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/features/auth/presentation/widgets/otp_page.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool _isNotValidate = false;

  void forgotPassword() async {
    if (emailController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
      };
      try {
        var res = await http.post(
          Uri.parse(forgotPass),
          body: jsonEncode(regBody),
          headers: {"Content-Type": "application/json"},
        );
        var jsonResponse = jsonDecode(res.body);

        if (jsonResponse['msg'] ==
            "please check your inbox of your mail and reset.") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OTPPage(
                otp: jsonResponse['otp'],
                email: emailController.text,
              ),
            ),
          );

          AlertDialogToast.showToast(
              "OTP has been sent.", AppColor.connectionLost);
        } else {
          AlertDialogToast.showToast(jsonResponse['msg'], AppColor.danger);
        }
      } catch (e) {
        AlertDialogToast.showToast(
            "Something went wrong. Please try again later", AppColor.danger);
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
      AlertDialogToast.showToast("Something went wrong.", AppColor.danger);
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
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'Reset your password!',
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
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
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
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Email Address',
                ),
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
                      forgotPassword(),
                    }
                },
                label: Text('Request OTP'),
                backgroundColor: AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
