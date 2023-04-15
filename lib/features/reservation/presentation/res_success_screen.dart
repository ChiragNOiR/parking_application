// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/features/reservation/presentation/widgets/text_style_res.dart';
import 'package:parking_app/features/reservation/presentation/widgets/time_box_design.dart';
import 'package:provider/provider.dart';

import 'package:parking_app/core/presentation/theme/app_color.dart';

import '../../../core/shared/config.dart';
import '../../profile/application/user_provider.dart';
import '../../res_history/domain/history_model.dart';

class ReservationSuccess extends StatefulWidget {
  const ReservationSuccess({super.key});

  @override
  State<ReservationSuccess> createState() => _ReservationSuccessState();
}

class _ReservationSuccessState extends State<ReservationSuccess> {
  late List<HistoryModel> list = [];
  Future<List<HistoryModel>> getBookingHistory() async {
    try {
      final id = Provider.of<CurrentUser>(context).user.userId;
      final response = await http.get(Uri.parse('$getBookingDetails/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['success'];
        return jsonList.map((json) => HistoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load History Data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load History Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: 400,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 400 / 220,
                    child: Image.network(
                      'https://cdn.discordapp.com/attachments/748249459166806118/1096851780819751052/empty-parking-lot-parking-lane-outdoor-public-park_1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: SizedBox(
                      height: 40,
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        label: Text(
                          'CLOSE',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 130,
                    child: Image.network(
                      'https://cdn.discordapp.com/attachments/748249459166806118/1096853106949640192/PngItem_2548444_1.png',
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 210,
                    child: Image.network(
                      'https://cdn.discordapp.com/attachments/748249459166806118/1096853107163529396/CITYPNG_1.png',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextStyleRes(
                    heading: 'Parking ID',
                    text: 'DADWADWADWAD',
                  ),
                  const TextStyleRes(
                    heading: 'Vehicle',
                    text: 'Honda',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextStyleRes(
                        heading: 'Payment',
                        text: 'Rs. 60 (Cash)',
                      ),
                      TextStyleRes(
                        heading: 'Parking Spot',
                        text: 'AA-01',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 376,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 30,
                              child: Text(
                                'Start Time'.toUpperCase(),
                                style: GoogleFonts.pragatiNarrow(
                                    fontSize: 20, color: Color(0xFF8B8686)),
                              ),
                            ),
                            const Positioned(
                              top: 10,
                              left: 130,
                              child: TimeBox(),
                            ),
                            const Positioned(
                              top: 10,
                              left: 150,
                              child: TimeBox(),
                            ),
                            const Positioned(
                              top: 10,
                              left: 170,
                              child: TimeBox(),
                            ),
                            const Positioned(
                              top: 5,
                              left: 190,
                              child: Icon(
                                Icons.location_on_rounded,
                              ),
                            ),
                            const Positioned(
                              top: 10,
                              left: 220,
                              child: TimeBox(),
                            ),
                            const Positioned(
                              top: 10,
                              left: 240,
                              child: TimeBox(),
                            ),
                            const Positioned(
                              top: 10,
                              left: 260,
                              child: TimeBox(),
                            ),
                            Positioned(
                              left: 280,
                              child: Text(
                                'end Time'.toUpperCase(),
                                style: GoogleFonts.pragatiNarrow(
                                    fontSize: 20,
                                    color: const Color(0xFF8B8686)),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 15,
                              child: Text(
                                '11:30 AM'.toUpperCase(),
                                style: GoogleFonts.reemKufi(
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 5,
                              child: Text(
                                '11:30 AM'.toUpperCase(),
                                style: GoogleFonts.reemKufi(
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'parking location'.toUpperCase(),
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 400,
                    child: Center(
                      child: Text(
                        'Kathmandu',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Color(0xFF706F6E),
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 380,
                      height: 60,
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        backgroundColor: AppColor.primary,
                        label: Text(
                          'Download Script'.toUpperCase(),
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
