import 'dart:convert';

import 'package:flutter/material.dart';
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
    reserveParking() async {
      var regBody = {
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

    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            Text(_loc.title),
            Text(_loc.description),
            Text(_loc.area),
            Text(_loc.slots),
            SizedBox(
              height: 100,
            ),
            Text('Set Start Time'),
            Text(
                "${selectedStartTime.hour}:${selectedStartTime.minute} ${selectedStartTime.period}"),
            ElevatedButton(
              onPressed: () {
                _selectStartTime(context);
              },
              child: Text('set start time'),
            ),
            Text('Set End Time'),
            Text(
                "${selectedEndTime.hour}:${selectedEndTime.minute} ${selectedEndTime.period}"),
            ElevatedButton(
              onPressed: () {
                _selectEndTime(context);
              },
              child: Text('set end time'),
            ),
            SizedBox(
              height: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                reserveParking();
              },
              label: Text('Testing Stuff'),
            )
          ],
        ),
      )),
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
}
