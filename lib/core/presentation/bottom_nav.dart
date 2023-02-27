import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/bookings/presentation/bookings.dart';
import 'package:parking_app/features/home/presentation/home_page.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    List pages = const [
      HomePage(),
      Bookings(),
      Profile(),
    ];
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: GNav(
        onTabChange: (index) {},
        color: AppColor.black,
        backgroundColor: AppColor.primary,
        activeColor: AppColor.black,
        gap: 8,
        padding: const EdgeInsets.all(16),
        haptic: true,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.history,
            text: 'History',
          ),
          GButton(
            icon: Icons.face,
            text: 'Profile',
          ),
        ],
      ),
      // NavBar: const NavBar(
      //   items: [
      //     NavBarItem(
      //       label: 'Home',
      //       icon: Icon(Icons.home_outlined),
      //     ),
      //     NavBarItem(
      //       label: 'Bookings',
      //       icon: Icon(Icons.arrow_circle_down_outlined),
      //     ),
      //     NavBarItem(
      //       label: 'Profile',
      //       icon: Icon(Icons.face),
      //     ),
      //   ],
      // ),
    );
  }
}
