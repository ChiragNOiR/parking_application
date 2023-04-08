import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/auth/presentation/login_page.dart';
import 'package:parking_app/features/home/presentation/widgets/components/drawer_header_slider.dart';
import 'package:parking_app/features/home/presentation/widgets/components/drawer_list.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:parking_app/features/profile/presentation/privacy_policy/privacy_policy.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';
import 'package:parking_app/features/res_history/presentation/history.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const History(),
              ),
            ),
          ),
          DrawerListTile(
            leading: Icons.policy,
            title: 'Policy',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ),
              );
            },
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
            height: 80,
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
                  await UserService().logOut(context);
                  // ignore: use_build_context_synchronously
                  context.read<CurrentUser>().logout();
                  // ignore: use_build_context_synchronously
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
