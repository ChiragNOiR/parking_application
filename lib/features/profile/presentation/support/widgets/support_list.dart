import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportList extends StatelessWidget {
  const SupportList(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageRadius,
      required this.image,
      this.onPressed});

  final String title;
  final String subtitle;
  final double imageRadius;
  final String image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(image),
            radius: imageRadius,
          )),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      onTap: onPressed,
    );
  }
}
