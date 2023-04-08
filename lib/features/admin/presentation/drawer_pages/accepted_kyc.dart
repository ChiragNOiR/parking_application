import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../core/presentation/theme/text_style.dart';
import '../../../../core/shared/config.dart';
import '../../../profile/application/user_provider.dart';
import '../../../profile/domain/kyc_model.dart';
import '../kyc_details_page.dart';
import '../widgets/kyc_verification_panel.dart';

class ApprovedRequest extends StatefulWidget {
  const ApprovedRequest({super.key});

  @override
  State<ApprovedRequest> createState() => _ApprovedRequestState();
}

class _ApprovedRequestState extends State<ApprovedRequest> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Approved KYC',
          style: AppStyle.profileHeading,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Approved KYC',
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

                          if (kycdetail.status == "approved") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KycDetailPage(
                                            heading: "Approved KYC",
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
                            return SizedBox();
                          }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
