import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/presentation/support/widgets/support_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/presentation/theme/text_style.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  void launchPhoneDialer(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
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
                            'Help & Support',
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
                                launchPhoneDialer('9861015731');
                              },
                              backgroundColor: const Color(0xFF11D195),
                              label: const Text('Direct Call'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SupportList(
                      title: 'Facebook/Messenger',
                      subtitle: '(Chats Only)',
                      imageRadius: 11,
                      image: 'assets/icons/messenger.png',
                    ),
                    SupportList(
                      title: '9861015731',
                      subtitle: '(WhatsApp - Chats Only)',
                      imageRadius: 11,
                      image: 'assets/icons/whatsapp.png',
                    ),
                    SupportList(
                      title: '9861015731',
                      subtitle: '(Viber - Chats Only)',
                      imageRadius: 11,
                      image: 'assets/icons/viber.png',
                    ),
                    SupportList(
                      title: '1600-03-6-3255',
                      subtitle: '(Toll Free)',
                      imageRadius: 11,
                      image: 'assets/icons/call.png',
                      onPressed: () {
                        launchPhoneDialer('1600-03-6-3255');
                      },
                    ),
                    SupportList(
                      title: '01-4330435',
                      subtitle: '(Landline)',
                      imageRadius: 11,
                      image: 'assets/icons/call.png',
                      onPressed: () {
                        launchPhoneDialer('01-4330435');
                      },
                    ),
                    SupportList(
                      title: 'support@pickpark.com.np',
                      subtitle: '(Email Address)',
                      imageRadius: 11,
                      image: 'assets/icons/email.png',
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
