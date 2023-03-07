import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail(
      {super.key,
      required this.icon,
      required this.title,
      required this.sub_title});
  final IconData icon;
  final String title;
  final String sub_title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 25,
            color: Color(0xFF11D195),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 13,
            color: Color(0xFF6B6464),
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          sub_title,
          style: GoogleFonts.roboto(
            fontSize: 10,
            color: Color(0xFFA19999),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
