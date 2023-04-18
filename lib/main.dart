import 'package:flutter/material.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/home/application/temple_image_provider.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/application/vehicle_provider.dart';
import 'package:parking_app/features/reservation/application/reservation_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  runApp(
    MultiProvider(
      //need to be run while using mutiple provider in a same app
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(), //provider of user
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ExploreImageProvider(), //provider of image explore
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TempleImageProvider(), // provider of image temple
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleProvider(), //provider of image vehicle
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ReservationProvider(), //provider of image reservation
        ),
      ],
      // ignore: missing_required_param
      child: const MyApp(),
    ),
  );
}
