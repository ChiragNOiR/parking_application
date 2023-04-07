import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_app/features/reservation/presentation/bookings_confrim_page.dart';
import 'package:timezone/timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/explore/domain/location_model.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/reservation/domain/reservation_model.dart';
import 'package:provider/provider.dart';

class PopularListPage extends StatefulWidget {
  const PopularListPage({super.key, required this.location});
  final LocationModel location;

  @override
  State<PopularListPage> createState() => _PopularListPageState();
}

class _PopularListPageState extends State<PopularListPage> {
  late LocationModel _loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loc = widget.location;
  }

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Image.network(
                      _loc.cover!,
                      fit: BoxFit.fill,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _loc.title,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColor.primary,
                        ),
                        Text(
                          _loc.description,
                          style: GoogleFonts.dosis(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      _loc.des!,
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Rs.${_loc.price} ',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '/hour',
                            style: GoogleFonts.sourceCodePro(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Working Hours\n',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '7am - 5pm',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 180,
                        ),
                        Text(
                          'Open Now',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Facilities\n',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Open Space, Camera, Charging, Disabled Space',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 30),
                      child: SizedBox(
                        width: 300,
                        child: FloatingActionButton.extended(
                          label: Text(
                            'Proceed',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: AppColor.primary,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookingConfirmPage(location: _loc),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
