// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

class AuthButton extends StatelessWidget {
  AuthButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 229,
      child: FloatingActionButton.extended(
        onPressed: onTap,
        backgroundColor: AppColor.black,
        label: Text(
          text,
          style: AppStyle.button,
        ),
      ),
    );
  }
}
