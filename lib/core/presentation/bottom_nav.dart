// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:parking_app/features/home/presentation/home_page.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';

import '../../features/res_history/presentation/history.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  int _index = 0;

  List<Text> text = [
    const Text(
      'Home',
    ),
    const Text(
      'Like',
    ),
    const Text(
      'Search',
    ),
  ];
  PageController controller = PageController();
  final List pages = [
    const HomePage(),
    const History(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_index),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _index,
        onTabChange: (index) {
          setState(() {
            _index = index;
          });
        },
        color: Colors.grey,
        backgroundColor: Colors.black,
        activeColor: Colors.white,
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
    );
  }
}
