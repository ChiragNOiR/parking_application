import 'package:flutter/material.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/infrastructure/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  final UserService userService = UserService();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(
  //         create: (context) => UserProvider(userService: userService),
  //         child: MyApp(
  //           userService: userService,
  //           token: prefs.getString('token'),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(userService: userService),
        )
      ],
      child: MyApp(
        token: prefs.getString('token'),
        userService: userService,
      ),
    ),
  );
}
