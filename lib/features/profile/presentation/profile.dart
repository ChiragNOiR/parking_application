import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/core/shared/divider_text.dart';
import 'package:parking_app/features/profile/presentation/FAQs/faqs.dart';
import 'package:parking_app/features/profile/presentation/address/kyc.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/my_vehicle.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/vehicle.dart';
import 'package:parking_app/features/profile/presentation/privacy_policy/privacy_policy.dart';
import 'package:parking_app/features/profile/presentation/coupon/coupon.dart';
import 'package:parking_app/features/profile/presentation/support/support.dart';
import 'package:parking_app/features/profile/presentation/widgets/components/my_details.dart';
import 'package:parking_app/features/profile/presentation/widgets/profile_detail.dart';
import 'package:parking_app/features/profile/presentation/widgets/profile_picture.dart';
import 'package:parking_app/features/profile/presentation/widgets/wallet.dart';
import 'package:provider/provider.dart';

import '../application/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, value, child) {
          return Stack(
            children: [
              Container(
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
                            Text(
                              'Account',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: const Color(0xFF726666),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Provider.of<CurrentUser>(context).user.fullName,
                              style: AppStyle.profileHeading,
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
                                          builder: (context) => MyDetails()));
                                },
                                backgroundColor: const Color(0xFF11D195),
                                label: const Text('Profile'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                        child: Container(
                          height: 110,
                          width: 100,
                          child: Center(
                              child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              Provider.of<CurrentUser>(context, listen: false)
                                  .user
                                  .userProfile!,
                            ),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xFF11D195),
                  ),
                  width: 395,
                  height: 180,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ProfileWallet(),
                  ),
                ),
              ),
              Positioned(
                top: 260,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  width: 395,
                  height: 500,
                  child: Column(
                    children: [
                      ProfileDetail(
                        icon: Icons.car_crash,
                        title: 'My Vehicle',
                        sub_title: 'View Vehicle Information',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Vehicle()));
                        },
                      ),
                      ProfileDetail(
                        icon: Icons.location_on,
                        title: 'View KYC',
                        sub_title: 'View know your customer/client',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KYC(),
                              ));
                        },
                      ),
                      ProfileDetail(
                        icon: Icons.phone,
                        title: 'Support',
                        sub_title: 'View Support',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Support(),
                              ));
                        },
                      ),
                      ProfileDetail(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        sub_title: 'View Privacy Policy',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicy(),
                              ));
                        },
                      ),
                      ProfileDetail(
                        icon: Icons.backup_table,
                        title: 'Coupon',
                        sub_title: 'Reedeem promocode & get balance/offers',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Coupon(),
                              ));
                        },
                      ),
                      ProfileDetail(
                        icon: Icons.newspaper,
                        title: 'FAQs',
                        sub_title: 'View frequently Asked Questions',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FAQs(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
