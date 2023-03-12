import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_app/features/home/presentation/home_page.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:parking_app/features/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

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
        home: (JwtDecoder.isExpired(token) == false)
            ? HomePage(
                token: token,
              )
            : const SplashScreen());
  }
}
