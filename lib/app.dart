import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/bottom_nav.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:parking_app/features/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'features/admin/presentation/admin_home.dart';

class MyApp extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    UserService().getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.dmSans().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ))),
      // home: Provider.of<CurrentUser>(context).user.token.isNotEmpty
      //     ? const HomePage()
      //     : const SplashScreen(),

      home: Provider.of<CurrentUser>(context).user.token.isNotEmpty
          ? (Provider.of<CurrentUser>(context).user.role == "user"
              ? const NavBar()
              : Provider.of<CurrentUser>(context).user.role == "admin"
                  ? const AdminHome()
                  : const SplashScreen())
          : const SplashScreen(),
    );
  }
}
