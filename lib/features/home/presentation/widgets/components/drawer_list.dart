import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.leading,
    required this.title,
    this.onPressed,
  });

  final IconData leading;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      leading: Icon(leading),
      title: Text(title, style: AppStyle.loginTexts),
      onTap: onPressed,
    );
  }
}
