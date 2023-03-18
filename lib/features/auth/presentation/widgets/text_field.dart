import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/text_style.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    super.key,
    required this.text,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.validator,
    this.icon,
    this.maxLength,
  });
  final String text;
  final String? errorText;
  final TextEditingController? controller;
  bool obscureText;
  IconData? icon;
  TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 350,
        child: TextFormField(
          maxLength: widget.maxLength,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              errorText: widget.errorText,
              label: Text(
                widget.text,
                style: AppStyle.loginTexts,
              ),
              suffix: IconButton(
                icon: Icon(widget.icon),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                    widget.icon = widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off;
                  });
                },
              )),
        ),
      );
}
