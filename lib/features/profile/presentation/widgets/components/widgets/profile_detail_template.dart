import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleTextTemplate extends StatelessWidget {
  const TitleTextTemplate({super.key, required this.title, required this.text});
  final String title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title\n',
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9A9494),
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: text,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B6464),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
