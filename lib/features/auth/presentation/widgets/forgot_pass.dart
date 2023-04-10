import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/toast.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
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
                    'Reset your password!',
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
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Email Address',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FloatingActionButton.extended(
              onPressed: () {
                AlertDialogToast.showToast(
                  "Link to reset password has been sent.",
                  AppColor.connectionLost,
                );
                Navigator.pop(context);
              },
              label: Text('Request'),
              backgroundColor: AppColor.primary,
            ),
          )
        ],
      ),
    );
  }
}
