import 'package:flutter/material.dart';
import 'package:parking_app/features/home/presentation/drawer_nav/widgets/setting_body.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: settingsBody()),
    );
  }

  Widget settingsBody() => const SettingsBody();
}
