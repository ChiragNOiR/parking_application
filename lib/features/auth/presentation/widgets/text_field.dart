import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/text_style.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    super.key,
    required this.text,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
  });
  final String text;
  final String? errorText;
  final TextEditingController? controller;
  bool obscureText;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 350,
        child: TextFormField(
          // validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            errorText: errorText,
            label: Text(
              text,
              style: AppStyle.loginTexts,
            ),
          ),
        ),
      );
}
