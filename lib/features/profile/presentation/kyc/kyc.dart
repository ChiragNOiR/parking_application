import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/profile/domain/kyc_model.dart';
import 'package:parking_app/features/profile/presentation/kyc/add_kyc.dart';
import 'package:parking_app/features/profile/presentation/kyc/widgets/kyc_template.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/theme/text_style.dart';
import 'package:http/http.dart' as http;

import '../../application/user_provider.dart';

class KYC extends StatefulWidget {
  const KYC({super.key});

  @override
  State<KYC> createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  late List<KYCModel> list = [];
  Future<List<KYCModel>> getKyc() async {
    try {
      final id = Provider.of<CurrentUser>(context).user.userId;
      final response = await http.get(Uri.parse('$getKycById/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['success']['userKyc'];
        return jsonList.map((json) => KYCModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Kyc Data');
      }
    } catch (e) {
      throw Exception('Failed to load Vehicle Data: $e');
    }
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
                            child: Icon(Icons.arrow_back),
                            onTap: () => Navigator.pop(context),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'KYC',
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
                                      builder: (context) => const AddKYC(),
                                    ));
                              },
                              backgroundColor: const Color(0xFF11D195),
                              label: const Text('Update KYC'),
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
                child: FutureBuilder<List<KYCModel>>(
                  future: getKyc(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final kycMap = snapshot.data!;
                      return ListView.builder(
                          itemCount: kycMap.length,
                          itemBuilder: (context, index) {
                            KYCModel kyc = kycMap[index];
                            if (kyc.status == "pending") {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Personal Details'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 350,
                                      height: 500,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                        ),
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KYCTemplate(
                                                title: 'Name',
                                                text: kyc.name,
                                              ),
                                              KYCTemplate(
                                                title: 'Address',
                                                text: kyc.address,
                                              ),
                                              KYCTemplate(
                                                title: 'D.O.B',
                                                text: kyc.dob,
                                              ),
                                              KYCTemplate(
                                                title: 'License Office',
                                                text: kyc.licenseOffice,
                                              ),
                                              KYCTemplate(
                                                title: 'License No.',
                                                text: kyc.licenseNumber,
                                              ),
                                              KYCTemplate(
                                                title: 'Citizenship Number',
                                                text: kyc.citizenNumber,
                                              ),
                                              KYCTemplate(
                                                title: 'Category',
                                                text: kyc.category,
                                              ),
                                              KYCTemplate(
                                                title: 'Date of Issue',
                                                text: kyc.doi,
                                              ),
                                              KYCTemplate(
                                                title: 'Date of Expiry',
                                                text: kyc.doe,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (kyc.status == "approved") {
                              return Center(
                                child: Text('KYc is still on pending'),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('KYC Rejected'),
                                  ],
                                ),
                              );
                            }
                          });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
