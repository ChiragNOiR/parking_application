import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_app/core/shared/divider_text.dart';
import 'package:http/http.dart' as http;

import '../../../../core/shared/config.dart';
import '../../../../core/shared/parking_list.dart';
import '../../../reservation/presentation/populat_list_page.dart';
import '../../domain/location_model.dart';

class ExploreMall extends StatefulWidget {
  const ExploreMall({super.key});

  @override
  State<ExploreMall> createState() => _ExploreMallState();
}

class _ExploreMallState extends State<ExploreMall> {
  late List<LocationModel> list = [];
  Future<List<LocationModel>> getMall() async {
    try {
      final response = await http.get(Uri.parse(getMallList));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pandits');
      }
    } catch (e) {
      throw Exception('Failed to load pandits: $e');
    }
  }

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
                    'https://english.khabarhub.com/wp-content/uploads/2019/08/No-Parking-1.jpg',
                    width: 600,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Popular
            const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: DividerText(
                  text: 'POPULAR',
                )),
            FutureBuilder<List<LocationModel>>(
              future: getMall(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final list = snapshot.data!;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        LocationModel location = list[index];
                        // final img = Provider.of<TempleImageProvider>(context)
                        //     .tempImg[index];
                        return Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PopularListPage(location: location),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: 160,
                                  height: 250,
                                  child: Image.network(
                                      fit: BoxFit.cover, location.image),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: DividerText(text: 'NEARBY'),
            ),
            FutureBuilder<List<LocationModel>>(
              future: getMall(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final list = snapshot.data!;
                  return SizedBox(
                    height: 230,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        LocationModel location = list[index];
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PopularListPage(location: location),
                                  )),
                              child: ParkingListTile(
                                image: Image.asset(
                                    'assets/images/parking_logo.png'),
                                title: location.title,
                                subtitle: '${location.slots} Slots Available',
                                trailing: '${location.distance} M',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
