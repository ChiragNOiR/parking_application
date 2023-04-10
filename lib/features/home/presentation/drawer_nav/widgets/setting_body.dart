import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/presentation/profile.dart';
import 'package:parking_app/features/profile/presentation/widgets/components/my_details.dart';
import 'package:provider/provider.dart';

import '../../../domain/setting_model.dart';
import 'components/appereance_section.dart';
import 'components/general_section.dart';
import 'components/subscription_section.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Color(0xFFA2A2B5)),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFA2A2B5),
            )),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            buildProfileImage(),
            const SizedBox(
              height: 7,
            ),
            Text(
              Provider.of<CurrentUser>(context).user.fullName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              Provider.of<CurrentUser>(context).user.userEmail,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFA2A2B5)),
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MyDetails();
                    },
                  ));
                },
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'View Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'General',
              style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            GeneralSectionMethod(),
            const SizedBox(
              height: 25,
            ),
            Text(
              'My subscriptions',
              style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SubscriptionsSectionMethod(),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Appearance',
              style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            AppearanceSectionMethod(),
          ],
        ),
      ),
    );
  }

  Widget buildProfileImage() => CircleAvatar(
        radius: 50.0,
        child: ClipRRect(
          // ignore: sort_child_properties_last
          child: Image.network(
              Provider.of<CurrentUser>(context).user.userProfile!),
          borderRadius: BorderRadius.circular(50.0),
        ),
      );
}
