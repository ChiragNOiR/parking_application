import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/res_history/domain/history_model.dart';
import 'package:parking_app/features/res_history/presentation/see_details.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../profile/application/user_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
      throw Exception('Failed to load Vehicle Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 100),
                child: Text(
                  'MY BOOKINGS',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: getBookingHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final historyMap = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      reverse: false,
                      itemCount: historyMap.length,
                      itemBuilder: (context, index) {
                        HistoryModel his = historyMap[index];

                        if (his.status == "canceled") {
                          return SizedBox.shrink();
                        }

                        // get the booking date from the HistoryModel object
                        DateTime bookingDate = DateTime.parse(his.date);
                        DateTime today = DateTime.now();
                        // compare the booking date with today's date
                        bool isBookedToday = bookingDate.year == today.year &&
                            bookingDate.month == today.month &&
                            bookingDate.day == today.day;

                        // set the color of the container based on the booking date
                        Color containerColor =
                            isBookedToday ? AppColor.primary : Colors.white;

                        String input = his.startTime;
                        RegExp pattern = RegExp('[a-zA-Z\\(\\)]');
                        String output = input.replaceAll(pattern, '');
                        DateTime myDate = DateTime.now();
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: containerColor,
                                  ),
                                  height: 150,
                                  width: 350,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateTime.now().day == myDate.day
                                            ? "Parking on"
                                            : "Parked on",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      RichText(
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: DateFormat('d MMMM, ')
                                              .format(DateTime.parse(his.date)),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: output,
                                              style: GoogleFonts.sourceCodePro(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          Text(
                                            his.location,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: AppColor.danger,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                                bottom: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SeeDetails(history: his),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 350,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9DF8B1),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'See Details',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
