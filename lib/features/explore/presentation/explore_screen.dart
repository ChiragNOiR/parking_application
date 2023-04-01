import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/core/shared/divider_text.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/explore/domain/location_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../core/shared/parking_list.dart';
import '../../reservation/presentation/populat_list_page.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late List<LocationModel> list = [];
  Future<List<LocationModel>> getTemple() async {
    try {
      final response = await http.get(Uri.parse(getTempleList));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Temple Data');
      }
    } catch (e) {
      throw Exception('Failed to load Temple Data: $e');
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
                child: DividerText(
                  text: 'POPULAR',
                )),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: Provider.of<ExploreImageProvider>(context)
                    .exploreArea
                    .length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final explore = Provider.of<ExploreImageProvider>(context)
                      .exploreArea[index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 185,
                        height: 250,
                        child: Image.network(
                          explore.imageUrl,
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
            FutureBuilder<List<LocationModel>>(
              future: getTemple(),
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
                                subtitle: '00 Slots Available',
                                trailing: '600 m',
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
