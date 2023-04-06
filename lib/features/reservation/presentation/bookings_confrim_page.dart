// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loc = widget.location;

    _selectedDate = DateTime.now();
  }

  reserveParking() async {
    var regBody = {
      "userId": Provider.of<CurrentUser>(context, listen: false).user.userId,
      "fullName":
          Provider.of<CurrentUser>(context, listen: false).user.fullName,
      "email":
          Provider.of<CurrentUser>(context, listen: false).user.userAddress,
      // "company":
      //     // Provider.of<ReservationModel>(context, listen: false).company,
      //     '',
      "contact":
          Provider.of<CurrentUser>(context, listen: false).user.userContact,
      "location": _loc.title,
      "price": _loc.price,
      "startTime": selectedStartTime.toString(),
      "endTime": selectedEndTime.toString(),
    };
    print(regBody);
    try {
      final res = await http.post(
        Uri.parse(setReservation),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"},
      );
      print(res.body);
      var jsonResponse = jsonDecode(res.body);
      print(jsonResponse['success']);

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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Text(
                        'Clear',
                        style: GoogleFonts.poppins(
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Select Date: ',
                    style: GoogleFonts.poppins(
                      color: AppColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Text(
                      formatter.format(_selectedDate!),
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Location: ',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
              SizedBox(
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
              SizedBox(
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
                        MaterialPageRoute(builder: (context) => SetTimePage()),
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    );
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  // ignore: non_constant_identifier_names
  SetTimePage() {
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
                height: 30,
              ),
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Text('Enter'),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                    ),
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
