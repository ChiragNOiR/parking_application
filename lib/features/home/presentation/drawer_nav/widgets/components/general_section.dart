import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Column GeneralSectionMethod() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        height: 130,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(78, 78, 97, 0.2),
            borderRadius: BorderRadius.circular(10)),
        child: ListView(
          children: [
            ListTile(
              // leading: Image.asset(
              //   'assets/icons/security.png',
              //   height: 30,
              // ),
              title: Wrap(
                spacing: 122,
                children: [
                  Text(
                    'Security',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF)),
                  ),
                  Text(
                    'FaceID',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFA2A2B5)),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              iconColor: Colors.grey,
            ),
            ListTile(
              // leading: Image.asset(
              //   'assets/icons/iCloud.png',
              //   height: 30,
              // ),
              iconColor: Colors.grey,
              title: Wrap(
                spacing: 122,
                children: [
                  Text(
                    'iCloud Sync',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF)),
                  ),
                  Text(
                    'Off',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFA2A2B5)),
                  ),
                ],
              ),

              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ],
        ),
      ),
    ],
  );
}
