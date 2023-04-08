import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/presentation/FAQs/widgets/question_panel.dart';
import 'package:parking_app/features/profile/presentation/support/support.dart';

import '../../../../core/presentation/theme/app_color.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
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
                            'Frequently Asked Questions',
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
                              label: const Text('Contact Support'),
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
                        'General Questions',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const QuestionPanel(text: 'How to use Pick&Park ?'),
                      const QuestionPanel(text: 'Offers'),
                      const QuestionPanel(text: 'Vehicle Details'),
                      const QuestionPanel(text: 'Loyalty & Rewards'),
                      const QuestionPanel(text: 'How to park your vehicle?')
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
