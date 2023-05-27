import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:parking_app/features/auth/presentation/login_page.dart';
import 'package:parking_app/features/auth/presentation/widgets/new_pass.dart';

import '../../../../core/presentation/theme/app_color.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.otp, required this.email});
  final String otp;
  final String email;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool _isNotValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                Text(
                  'Please insert your OTP',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: otpController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'One time password',
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: FloatingActionButton.extended(
            onPressed: () => {
              if (otpController.text.isNotEmpty)
                {
                  if (otpController.text == widget.otp)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordPage(
                            email: widget.email,
                          ),
                        ),
                      ),
                      AlertDialogToast.showToast(
                          "OTP Verified Successfully.", AppColor.danger)
                    }
                  else
                    {
                      AlertDialogToast.showToast(
                          "Please check OTP and try again", AppColor.danger)
                    }
                }
              else
                {
                  AlertDialogToast.showToast(
                      "Something went wrong!!", AppColor.danger)
                }
            },
            label: Text('Validate OTP'),
            backgroundColor: AppColor.primary,
          ),
        ),
      ],
    ));
  }
}
