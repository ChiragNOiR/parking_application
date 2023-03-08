import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/presentation/widgets/components/widgets/profile_detail_template.dart';

import '../../../../../core/presentation/theme/text_style.dart';
import '../profile_detail.dart';
import '../profile_picture.dart';
import '../wallet.dart';

class MyDetails extends StatelessWidget {
  const MyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: 180,
                color: Color(0xFFE8F4F9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'My Profile',
                            style: AppStyle.profileHeading,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    ProfilePicture(),
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
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TitleTextTemplate(
                        title: 'Full Name',
                        text: 'User',
                      ),
                      TitleTextTemplate(
                        title: 'Email Address',
                        text: 'user@gmail.com',
                      ),
                      TitleTextTemplate(
                        title: 'Phone Number',
                        text: '9807849902',
                      ),
                      TitleTextTemplate(
                        title: 'Address',
                        text: 'Baneshwor',
                      ),
                      TitleTextTemplate(
                        title: 'City',
                        text: 'Kathmandu',
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
