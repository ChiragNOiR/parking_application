import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/admin/presentation/pending_details_page.dart';
import 'package:parking_app/features/admin/presentation/widgets/kyc_verification_panel.dart';
import 'package:parking_app/features/profile/application/kyc_provider.dart';
import 'package:parking_app/features/profile/domain/kyc_model.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/shared/config.dart';

import '../../auth/presentation/login_page.dart';
import '../../profile/application/user_provider.dart';
import '../../profile/domain/vehicle_model.dart';

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
      print(e);
      throw Exception('Failed to load KYC Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Home',
            style: AppStyle.profileHeading,
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {},
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  await UserService().logOut(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                label: Text('logout'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Pending Requests',
                                      style: AppStyle.profileHeading,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PendingDetailsPage(
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
                            }
                            // return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     if (Provider.of<KYCModel>(context).status ==
                            //         "pending")
                            //       {}
                            //   ],
                            // );
                          });
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
