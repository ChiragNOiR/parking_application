import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/shared/divider_text.dart';

import '../../../core/shared/parking_list.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Stack
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/www.webp',
                  width: 600,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                )
              ],
            ),
          ),
          //Popular
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: DividerText(text: 'POPULAR'),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: 100,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: 185,
                      height: 250,
                      child: Image.asset(
                        'assets/images/rrrr.webp',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: DividerText(text: 'NEARBY'),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ParkingListTile(
                      image: Image.asset('assets/images/parking_logo.png'),
                      title: 'Park Hero',
                      subtitle: '00 Slots Available',
                      trailing: '500 m',
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
