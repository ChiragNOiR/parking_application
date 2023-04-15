import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/admin/presentation/drawer_pages/accepted_kyc.dart';
import 'package:parking_app/features/admin/presentation/drawer_pages/rejected_kyc.dart';
import 'package:parking_app/features/admin/presentation/kyc_details_page.dart';
import 'package:parking_app/features/admin/presentation/widgets/kyc_verification_panel.dart';
import 'package:parking_app/features/profile/domain/kyc_model.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/shared/config.dart';

import '../../auth/presentation/login_page.dart';
import '../../profile/application/user_provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
  }

  late List<KYCModel> kyc = [];
  Future<List<KYCModel>> getKyc() async {
    try {
      // ignore: unused_local_variable
      final id = Provider.of<CurrentUser>(context).user.userId;

      final response = await http.get(Uri.parse(getKycDetails));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['success'];

        return jsonList.map((json) => KYCModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load KYC Data');
      }
    } catch (e) {
      throw Exception('Failed to load KYC Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Home',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                ),
                child: Text(
                  'Admin Panel',
                  style: AppStyle.profileHeading,
                ),
              ),
              ListTile(
                title: const Text('Approved Requests'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ApprovedRequest(),
                      ));
                },
              ),
              ListTile(
                title: const Text('Rejected Requests'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RejectedRequest(),
                      ));
                },
              ),
              const SizedBox(
                height: 350,
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  await UserService().logOut(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                label: const Text('logout'),
                backgroundColor: AppColor.danger,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pending Requests',
                  style: AppStyle.profileHeading,
                ),
              ),
              Center(
                child: FutureBuilder<List<KYCModel>>(
                  future: getKyc(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final kyc = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: kyc.length,
                        itemBuilder: (context, index) {
                          KYCModel kycdetail = kyc[index];

                          if (kycdetail.status == "pending") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KycDetailPage(
                                            heading: "Pending KYC Verification",
                                            kycModel: kycdetail),
                                      ),
                                    );
                                  },
                                  child: KycVerificationPanel(
                                    profurl: kycdetail.profile.toString(),
                                    name: kycdetail.name,
                                    address: kycdetail.address,
                                    status: kycdetail.status,
                                  ),
                                )
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
