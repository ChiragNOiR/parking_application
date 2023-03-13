import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/auth/presentation/login_page.dart';
import 'package:parking_app/features/home/presentation/widgets/components/drawer_header_slider.dart';
import 'package:parking_app/features/home/presentation/widgets/components/drawer_list.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          const DrawerHeaderSlider(),
          DrawerListTile(
            leading: Icons.home,
            title: 'Home',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            ),
          ),
          DrawerListTile(
            leading: Icons.history,
            title: 'History',
            onPressed: () {},
          ),
          DrawerListTile(
            leading: Icons.policy,
            title: 'Policy',
            onPressed: () {},
          ),
          DrawerListTile(
            leading: Icons.notification_important,
            title: 'Notifications',
            onPressed: () {},
          ),
          const Divider(
            color: Colors.white,
          ),
          DrawerListTile(
            leading: Icons.newspaper,
            title: 'My Documents',
            onPressed: () {},
          ),
          DrawerListTile(
            leading: Icons.settings,
            title: 'Settings',
            onPressed: () {},
          ),
          const SizedBox(
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: AppStyle.loginTexts,
                ),
                leading: const Icon(Icons.logout_outlined),
                onTap: () async {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const LoginPage(),
                  //     ));
                  await UserService().logOut(context);
                  context.read<CurrentUser>().logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
