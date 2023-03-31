import 'package:flutter/material.dart';
import 'package:parking_app/features/explore/domain/location_model.dart';

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

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
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
                "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period}"),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text('set start time'),
            ),
            Text('Set End Time'),
            ElevatedButton(
              onPressed: () {},
              child: Text('set end time'),
            ),
          ],
        ),
      )),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
