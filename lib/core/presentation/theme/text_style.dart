import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';

//static data textstyle
class AppStyle {
  static TextStyle splashscreenh1 = GoogleFonts.poppins(
    fontSize: 50.0,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF2D2D2F),
  );

  static TextStyle splashscreenh2 = GoogleFonts.poppins(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF2D2D2F),
  );
  static TextStyle splashscreenbutton = GoogleFonts.poppins(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle loginpageh1 = GoogleFonts.poppins(
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
    height: 1.2125,
  );

  static TextStyle loginpageh2 = GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: const Color(0xff565656),
    height: 1.2125,
  );

  static TextStyle loginTexts = GoogleFonts.poppins(
    fontSize: 26.0,
    color: const Color(0xFF6B6B6B),
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: 32.0,
    color: Colors.white,
  );

  static TextStyle loginpageh3 = GoogleFonts.poppins(
    fontSize: 15,
    color: const Color(0xFF6B6B6B),
  );

  static TextStyle homePageDivider = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle profileHeading = GoogleFonts.roboto(
    color: AppColor.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}
