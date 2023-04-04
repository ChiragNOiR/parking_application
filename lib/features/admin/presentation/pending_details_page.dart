import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/admin/presentation/widgets/kyc_detail_text.dart';
import 'package:parking_app/features/profile/domain/kyc_model.dart';

class PendingDetailsPage extends StatefulWidget {
  const PendingDetailsPage({super.key, required this.kycModel});
  final KYCModel kycModel;

  @override
  State<PendingDetailsPage> createState() => _PendingDetailsPageState();
}

class _PendingDetailsPageState extends State<PendingDetailsPage> {
  late KYCModel _kyc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kyc = widget.kycModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
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
              'Pending KYC Verification',
              style: AppStyle.profileHeading,
            ),
            SizedBox(
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
              text: _kyc.id,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Approve'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Reject'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
