import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/domain/user_model.dart';
import 'package:parking_app/features/profile/presentation/widgets/components/widgets/profile_detail_template.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/theme/text_style.dart';
import '../profile_detail.dart';
import '../profile_picture.dart';
import '../wallet.dart';

class MyDetails extends StatefulWidget {
  MyDetails(this.user, {Key? key}) : super(key: key);
  UserModel user;

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getAllUserDetails();
    });
  }

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
                    children: [
                      TitleTextTemplate(
                        title: 'Full Name',
                        text: widget.user.fullName!,
                      ),
                      TitleTextTemplate(
                        title: 'Email Address',
                        text: widget.user.email!,
                      ),
                      TitleTextTemplate(
                        title: 'Phone Number',
                        text: widget.user.phone!,
                      ),
                      TitleTextTemplate(
                        title: 'Address',
                        text: widget.user.address!,
                      ),
                      TitleTextTemplate(
                        title: 'City',
                        text: widget.user.address!,
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
