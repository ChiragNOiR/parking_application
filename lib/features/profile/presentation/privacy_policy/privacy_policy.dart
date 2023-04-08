import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/profile/presentation/privacy_policy/pp_text.dart';
import 'package:parking_app/features/profile/presentation/support/support.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: 180,
                color: const Color(0xFFE8F4F9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.arrow_back),
                            onTap: () => Navigator.pop(context),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Privacy Policy',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color(0xFF726666),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 35,
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Support(),
                                    ));
                              },
                              backgroundColor: const Color(0xFF11D195),
                              label: const Text('Contact Us'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                width: 395,
                height: 600,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Updated: April 1, 2022',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF726666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const PPText(
                        text:
                            'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure\nof Your information when You use the Service and tells You about Your privacy rights and how the\nlaw protects You.',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const PPText(
                        text:
                            'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Collecting and Using Your Personal Data',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Types of Data Collected',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Personal Data',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const PPText(
                        text:
                            'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const PPText(
                        text:
                            '1. Email address\n2. First name and last name\n3. Phone number\n4. Address, State, Province, ZIP/Postal code, City\n5. Usage Data',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
