import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

class DividerText extends StatelessWidget {
  const DividerText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.homePageDivider,
    );
  }
}
