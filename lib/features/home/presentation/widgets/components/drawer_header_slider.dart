import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:provider/provider.dart';

class DrawerHeaderSlider extends StatelessWidget {
  const DrawerHeaderSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                backgroundImage: NetworkImage(
                  Provider.of<CurrentUser>(context).user.userProfile!,
                ),
              ),
            ),
            Text(
              Provider.of<CurrentUser>(context).user.fullName.toUpperCase(),
              style: AppStyle.splashscreenbutton,
            )
          ],
        ),
      ),
    );
  }
}
