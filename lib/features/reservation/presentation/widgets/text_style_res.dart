import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleRes extends StatelessWidget {
  const TextStyleRes({
    Key? key,
    required this.heading,
    required this.text,
  }) : super(key: key);

  final String heading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: '$heading \n',
            style: GoogleFonts.pragatiNarrow(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: text,
                style: GoogleFonts.pragatiNarrow(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
