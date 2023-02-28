import 'package:flutter/material.dart';

class DrawerHeaderSlider extends StatelessWidget {
  const DrawerHeaderSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade800,
              Colors.cyan.shade400,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
