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
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExploreImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TempleImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReservationProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => KycProvider(),
        // )
      ],
      child: const MyApp(),
    ),
  );
}
