// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/shared/toast.dart';
import 'package:provider/provider.dart';

import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/admin/presentation/widgets/kyc_detail_text.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/domain/kyc_model.dart';

class KycDetailPage extends StatefulWidget {
  const KycDetailPage({
    Key? key,
    required this.kycModel,
    required this.heading,
  }) : super(key: key);
  final KYCModel kycModel;
  final String heading;

  @override
  State<KycDetailPage> createState() => _KycDetailPageState();
}

class _KycDetailPageState extends State<KycDetailPage> {
  late KYCModel _kyc;

  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _kyc = widget.kycModel;
  }

//approved method to change statu to approved while the API is hit
  Future<void> approved() async {
    var regBody = {
      'contact': _kyc.contact,
      'status': 'approved',
    };
    final id = Provider.of<CurrentUser>(context, listen: false).user.userId;
    var response = await http.post(
      Uri.parse('$statusKyc/$id/approved'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      AlertDialogToast.showToast(
        "KYC Approved",
        AppColor.primary,
      );
    } else {
      AlertDialogToast.showToast("Something Went Wrong!!", AppColor.danger);
    }
  }

//approved method to change statu to rejected while the API is hit

  Future<void> rejected() async {
    var regBody = {
      'contact': _kyc.contact,
      'status': 'rejected',
    };
    final id = Provider.of<CurrentUser>(context, listen: false).user.userId;
    var response = await http.post(
      Uri.parse('$statusKyc/$id/rejected'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      AlertDialogToast.showToast(
        "KYC Rejected",
        AppColor.danger,
      );
      Navigator.pop(context);
    } else {
      AlertDialogToast.showToast("Something Went Wrong!!", AppColor.danger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.heading,
              style: AppStyle.profileHeading,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(_kyc.profile),
                radius: 55,
              ),
            ),
            KycText(
              title: 'User ID',
              text: _kyc.userId,
            ),
            KycText(
              title: 'Full Name',
              text: _kyc.name,
            ),
            KycText(
              title: 'Address',
              text: _kyc.address,
            ),
            KycText(
              title: 'Date of Birth',
              text: _kyc.dob,
            ),
            KycText(
              title: 'License Office',
              text: _kyc.licenseOffice,
            ),
            KycText(
              title: 'License Number',
              text: _kyc.licenseNumber,
            ),
            KycText(
              title: 'CitizenShip Number',
              text: _kyc.citizenNumber,
            ),
            KycText(
              title: 'Category',
              text: _kyc.category,
            ),
            KycText(
              title: 'Contact Info.',
              text: _kyc.contact,
            ),
            KycText(
              title: 'Date of Issue',
              text: _kyc.doi,
            ),
            KycText(
              title: 'Date of Expiry',
              text: _kyc.doe,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_kyc.licensePhoto!),
                  ),
                ),
                height: 220,
                width: 370,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await approved();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 18),
                    ),
                  ),
                  child: const Text('Approve'),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await rejected();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 18),
                    ),
                  ),
                  child: const Text('Reject'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
