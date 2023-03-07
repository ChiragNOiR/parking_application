import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWallet extends StatelessWidget {
  const ProfileWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.wallet,
        color: Colors.white,
        size: 30,
      ),
      title: Text(
        'Wallet',
        style: GoogleFonts.roboto(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Quick Payment',
        style: GoogleFonts.roboto(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFFD9D1D1),
        ),
      ),
      trailing: Text(
        'Rs. 1000',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
