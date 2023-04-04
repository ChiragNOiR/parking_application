// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';

class KycText extends StatelessWidget {
  const KycText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: GoogleFonts.poppins(
              color: AppColor.danger,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: AppColor.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
