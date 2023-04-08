import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/presentation/theme/app_color.dart';
import '../../support/support.dart';

class HelpCoupon extends StatelessWidget {
  const HelpCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFD3D3D3),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.support_agent,
          color: AppColor.black,
        ),
        title: Text(
          'Do you want help?',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Support(),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Get Help',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: AppColor.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
