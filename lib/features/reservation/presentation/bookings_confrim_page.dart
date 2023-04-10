// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_app/core/presentation/bottom_nav.dart';
import 'package:parking_app/core/shared/toast.dart';
import 'package:parking_app/features/res_history/presentation/history.dart';
import 'package:parking_app/features/reservation/presentation/widgets/time_box_design.dart';
import 'package:provider/provider.dart';

import 'package:parking_app/core/presentation/theme/app_color.dart';

import '../../../core/shared/config.dart';
import '../../explore/domain/location_model.dart';
import '../../profile/application/user_provider.dart';

class BookingConfirmPage extends StatefulWidget {
  const BookingConfirmPage({
    Key? key,
    required this.location,
  }) : super(key: key);
  final LocationModel location;

  @override
  State<BookingConfirmPage> createState() => _BookingConfirmPageState();
}

class _BookingConfirmPageState extends State<BookingConfirmPage> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  late String searchAddr;
  late LocationModel _loc;
  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _loc = widget.location;

    _selectedDate = DateTime.now();

    _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(_loc.lat!), double.parse(_loc.long!)),
      zoom: 15,
    );
  }

  reserveParking() async {
    var regBody = {
      "userId": Provider.of<CurrentUser>(context, listen: false).user.userId,
      "fullName":
          Provider.of<CurrentUser>(context, listen: false).user.fullName,
      "email":
          Provider.of<CurrentUser>(context, listen: false).user.userAddress,
      "contact":
          Provider.of<CurrentUser>(context, listen: false).user.userContact,
      "location": _loc.title,
      "price": _loc.price,
      "startTime": selectedStartTime.toString(),
      "endTime": selectedEndTime.toString(),
      "date": _selectedDate.toString(),
      "status": "ongoing",
    };
    try {
      final res = await http.post(
        Uri.parse(setReservation),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"},
      );
      var jsonResponse = jsonDecode(res.body);

      if (jsonResponse['status']) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // alertDialog(context, 'Registered Successfully');
      } else {
        // alertDialog(context, 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: Text(
          _loc.title,
          style: GoogleFonts.roboto(
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _selectedDate = DateTime.now();
                  //     });
                  //   },
                  //   child: Text(
                  //     'Clear',
                  //     style: GoogleFonts.poppins(
                  //       color: Colors.blue.shade400,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text(
                  //   'Select Date: ',
                  //   style: GoogleFonts.poppins(
                  //     color: AppColor.primary,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     letterSpacing: 1,
                  //   ),
                  // ),
                  GestureDetector(
                    // onTap: () => _selectDate(context),

                    child: Text(
                      formatter.format(_selectedDate!),
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Location: ',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                width: 400,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                  },
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Please proceed to next page to set the time of parking.',
                style: GoogleFonts.poppins(
                  color: AppColor.danger,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: SizedBox(
                  width: 300,
                  child: FloatingActionButton.extended(
                    label: Text(
                      'PROCEED TO RESERVATION',
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
                            builder: (context) => SetTimePage(context)),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? startTimeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (startTimeOfDay != null && startTimeOfDay != selectedStartTime) {
      setState(() {
        selectedStartTime = startTimeOfDay;
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? endTimeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (endTimeOfDay != null && endTimeOfDay != selectedEndTime) {
      setState(() {
        selectedEndTime = endTimeOfDay;
      });
    }
  }

  // ignore: non_constant_identifier_names
  SetTimePage(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    String _getDaySuffix(int day) {
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    final DateFormat formatter =
        DateFormat('EEEEEEEE, d\'${_getDaySuffix(DateTime.now().day)}\' MMMM');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: Text(
          _loc.title,
          style: GoogleFonts.roboto(
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Parking Detail',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formatter.format(_selectedDate!),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.danger,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 30,
                      child: Text(
                        'ENTER',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: FloatingActionButton.extended(
                        heroTag: "enter",
                        label: Text(
                          "${selectedStartTime.hour}:${selectedStartTime.minute} ${selectedStartTime.hour < 12 ? "AM" : "PM"}",
                          style: GoogleFonts.poppins(
                            color: AppColor.danger,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectStartTime(context);
                          });
                        },
                        backgroundColor: const Color(0xFFF8EFEF),
                      ),
                    ),
                    const Positioned(
                      top: 58,
                      left: 100,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 58,
                      left: 130,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 58,
                      left: 160,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 58,
                      left: 190,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 90,
                      left: 190,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 123,
                      left: 190,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 153,
                      left: 190,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 183,
                      left: 190,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 183,
                      left: 220,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 183,
                      left: 250,
                      child: TimeBox(),
                    ),
                    const Positioned(
                      top: 183,
                      left: 280,
                      child: TimeBox(),
                    ),
                    Positioned(
                      top: 177,
                      left: 300,
                      child: Text(
                        'EXIT',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 210,
                      left: 270,
                      child: FloatingActionButton.extended(
                        heroTag: "exit",
                        label: Text(
                          "${selectedEndTime.hour}:${selectedEndTime.minute} ${selectedEndTime.hour < 12 ? "AM" : "PM"}",
                          style: GoogleFonts.poppins(
                            color: AppColor.danger,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectEndTime(context);
                          });
                        },
                        backgroundColor: const Color(0xFFF8EFEF),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Note:\n',
                    style: GoogleFonts.roboto(
                      color: AppColor.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '1. Parking is not allowed in any place that is not specifically striped or signed for parking.\n',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n2. Please follow all the traffic rules and regulations.\n',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n3. The Electric Vehicle will be given seperated chargable spaces of Level II Electric Vehicle Charging Stations,',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text: 'Extra Charges Applied.',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.red.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: SizedBox(
                  width: 300,
                  child: FloatingActionButton.extended(
                    label: Text(
                      'RESERVE YOUR SPACE',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: AppColor.primary,
                    onPressed: () {
                      AlertDialogToast.showToast(
                          "Slot Booked", AppColor.connectionLost);
                      reserveParking();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
