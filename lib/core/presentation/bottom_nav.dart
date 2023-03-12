import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/reservation/presentation/bookings.dart';
import 'package:parking_app/features/home/presentation/home_page.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  int _index = 0;
  List<Color> colors = [Colors.purple, Colors.pink, Colors.grey, Colors.teal];

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
    HomePage(),
    Bookings(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: PageView.builder(
    //     itemCount: 3,
    //     controller: controller,
    //     onPageChanged: (value) {
    //       setState(() {
    //         _index = value;
    //       });
    //     },
    //     itemBuilder: (context, index) {
    //       return Container(
    //         color: colors[index],
    //         child: Center(
    //           child: text[index],
    //         ),
    //       );
    //     },
    //   ),
    //   bottomNavigationBar: SafeArea(),
    // );

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
