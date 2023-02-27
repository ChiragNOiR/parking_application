import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.amber,
              child: Column(
                children: [
                  CircleAvatar(),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Hello',
              style: AppStyle.loginTexts,
            ),
          ),
          Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
