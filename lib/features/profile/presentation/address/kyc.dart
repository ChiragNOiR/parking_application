import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/presentation/address/add_address.dart';
import 'package:parking_app/features/profile/presentation/address/widgets/kyc_template.dart';

import '../../../../core/presentation/theme/text_style.dart';

class KYC extends StatefulWidget {
  const KYC({super.key});

  @override
  State<KYC> createState() => _KYCState();
}

class _KYCState extends State<KYC> {
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
                                      builder: (context) => const AddAddress(),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Details'),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 350,
                        height: 318,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                KYCTemplate(
                                  title: 'Name',
                                  text: '',
                                ),
                                KYCTemplate(
                                  title: 'Address',
                                  text: '',
                                ),
                                KYCTemplate(
                                  title: 'D.O.B',
                                  text: '',
                                ),
                                KYCTemplate(
                                  title: 'F/H Name',
                                  text: '',
                                ),
                                KYCTemplate(
                                  title: 'Citizenship No.',
                                  text: '',
                                ),
                                KYCTemplate(
                                  title: 'Phone No',
                                  text: '99',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Document Details'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
