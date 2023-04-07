import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/res_history/domain/history_model.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFD9D9D9),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 60),
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
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    FutureBuilder<List<HistoryModel>>(
                      future: getBookingHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final historyMap = snapshot.data!;
                          return ListView.builder(
                            itemCount: historyMap.length,
                            itemBuilder: (context, index) {
                              HistoryModel history = historyMap[index];
                              String input = history.startTime;
                              RegExp pattern = RegExp('[a-zA-Z\\(\\)]');
                              String output = input.replaceAll(pattern, '');
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Parked On",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: DateFormat('d MMMM, ').format(
                                            DateTime.parse(history.date)),
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
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                          history.location,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: AppColor.danger,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
