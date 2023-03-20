import 'package:flutter/material.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/home/application/temple_image_provider.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ],
      child: MyApp(),
    ),
  );
}
