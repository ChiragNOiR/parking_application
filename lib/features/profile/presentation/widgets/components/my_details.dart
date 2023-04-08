import 'package:flutter/material.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/presentation/widgets/components/widgets/profile_detail_template.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/theme/text_style.dart';
import '../profile_picture.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({Key? key}) : super(key: key);

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     // final provider = Provider.of<UserProvider>(context, listen: false);
  //     // provider.getAllUserDetails(context);

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrentUser>(context);
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
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'My Profile',
                          style: AppStyle.profileHeading,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                  const ProfilePicture(),
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
                      text: provider.user.fullName,
                    ),
                    TitleTextTemplate(
                      title: 'Email Address',
                      text: provider.user.userEmail,
                    ),
                    TitleTextTemplate(
                      title: 'Phone Number',
                      text: provider.user.userContact,
                    ),
                    TitleTextTemplate(
                      title: 'Address',
                      text: provider.user.userAddress,
                    ),
                    TitleTextTemplate(
                      title: 'City',
                      text: provider.user.userAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
