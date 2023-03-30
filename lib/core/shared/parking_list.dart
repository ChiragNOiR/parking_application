import 'package:flutter/material.dart';

class ParkingListTile extends StatelessWidget {
  const ParkingListTile(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.trailing});

  final Image image;
  final String title;
  final String subtitle;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 350,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: image,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(trailing),
      ),
    );
  }
}
