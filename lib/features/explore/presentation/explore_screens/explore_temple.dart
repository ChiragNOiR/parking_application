import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/shared/divider_text.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/home/application/temple_image_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared/parking_list.dart';

class ExploreTemple extends StatefulWidget {
  const ExploreTemple({super.key});

  @override
  State<ExploreTemple> createState() => _ExploreTempleState();
}

class _ExploreTempleState extends State<ExploreTemple> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Stack
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    fit: BoxFit.cover,
                    'https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2017/12/Pashupatinath-temple.jpg',
                    width: 600,
                  ),
                  IconButton(
                    visualDensity: VisualDensity.comfortable,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
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
                child: DividerText(
                  text: 'POPULAR',
                )),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount:
                    Provider.of<TempleImageProvider>(context).tempImg.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final img =
                      Provider.of<TempleImageProvider>(context).tempImg[index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: 160,
                          height: 250,
                          child: Image.asset(
                            fit: BoxFit.cover,
                            img.image,
                          ),
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
        ),
      )),
    );
  }
}
