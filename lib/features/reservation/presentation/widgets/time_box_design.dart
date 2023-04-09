import 'package:flutter/material.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xFFD9D9D9)),
    );
  }
}
