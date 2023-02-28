import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.onPressed,
  });

  final IconData leading;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.white,
      leading: Icon(leading),
      title: Text(title, style: AppStyle.loginTexts),
      onTap: () => onPressed,
    );
  }
}
