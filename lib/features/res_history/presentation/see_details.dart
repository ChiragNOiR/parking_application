// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:http/http.dart' as http;

import 'package:parking_app/features/res_history/domain/history_model.dart';
import 'package:parking_app/features/res_history/presentation/history.dart';
import 'package:parking_app/features/res_history/presentation/widgets/text_format.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/theme/app_color.dart';

class SeeDetails extends StatefulWidget {
  const SeeDetails({
    Key? key,
    required this.history,
  }) : super(key: key);
  final HistoryModel history;

  @override
  State<SeeDetails> createState() => _SeeDetailsState();
}

class _SeeDetailsState extends State<SeeDetails> {
  late HistoryModel _his;

  @override
  void initState() {
    super.initState();
    _his = widget.history;
  }

  Future<void> cancelRes() async {
    var regBody = {'location': _his.location, 'status': 'canceled'};
    final id = Provider.of<CurrentUser>(context, listen: false).user.userId;

    var response = await http.post(
      Uri.parse("$reservationCancelation/$id/canceled"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['success']);

    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // alertDialog(context, 'Registered Successfully');
    } else {
      // alertDialog(context, 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    String startInput = _his.startTime;
    RegExp pattern = RegExp('[a-zA-Z\\(\\)]');
    String startOutput = startInput.replaceAll(pattern, '');

    String endInput = _his.endTime;
    String endOutput = endInput.replaceAll(pattern, '');

    final today = DateTime.now();
    final reservationDate = DateTime.parse(_his.date);

    bool isTodayReservation = today.year == reservationDate.year &&
        today.month == reservationDate.month &&
        today.day == reservationDate.day;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DETAILS',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text(
                          'Back',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 1,
              child: Container(
                height: 300,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormat(
                        title: 'Location',
                        text: _his.location,
                      ),
                      TextFormat(
                        title: 'Full Name',
                        text: _his.fullName,
                      ),
                      TextFormat(
                        title: 'Contact',
                        text: _his.contact,
                      ),
                      TextFormat(
                        title: 'Date',
                        text: DateFormat('d MMMM, y')
                            .format(DateTime.parse(_his.date)),
                      ),
                      TextFormat(
                        title: 'Start Time',
                        text: startOutput,
                      ),
                      TextFormat(
                        title: 'End Time',
                        text: endOutput,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isTodayReservation)
              Center(
                child: SizedBox(
                  width: 200,
                  child: FloatingActionButton.extended(
                    heroTag: "cancelButton",
                    backgroundColor: Colors.red,
                    onPressed: () async {
                      await cancelRes();
                      AlertDialogToast.showToast(
                          "Slot Canceled", AppColor.danger);
                    },
                    label: Text(
                      'Cancel Reservation',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
