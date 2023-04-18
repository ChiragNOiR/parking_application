import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_adventure.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_mall.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_schools.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_temple.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/home/presentation/search_page.dart';
import 'package:parking_app/features/home/presentation/widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/divider_text.dart';
import '../../../../core/shared/config.dart';
import '../../../core/shared/parking_list.dart';
import '../../explore/domain/location_model.dart';
import 'package:http/http.dart' as http;

import '../../reservation/presentation/populat_list_page.dart';

class HomePage extends StatefulWidget {
  // final token;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late String email;
  late String title;

  late List<LocationModel> list = [];

  //get method to get nearby details
  Future<List<LocationModel>> getNearbyList() async {
    try {
      final response = await http.get(Uri.parse(getNearby));
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
        key: _key,
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _key.currentState?.openDrawer(),
                    icon: const Icon(
                      Icons.menu,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 310,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F2ED),
                        // border: Border.all(width: 1.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        child: Row(
                          children: const [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Search'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DividerText(text: 'NEARBY'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF11D195),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FutureBuilder<List<LocationModel>>(
                      future: getNearbyList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final list = snapshot.data!;
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              LocationModel location = list[index];
                              return Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PopularListPage(
                                              location: location),
                                        )),
                                    child: ParkingListTile(
                                      image: Image.asset(
                                          'assets/images/parking_logo.png'),
                                      title: location.title,
                                      subtitle:
                                          '${location.slots} Slots Available',
                                      trailing: '${location.distance} Km',
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DividerText(text: 'EXPLORE'),
              ),
              SizedBox(
                height: 410,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    Provider.of<ExploreImageProvider>(context).imageLength,
                    (index) {
                      final explore = Provider.of<ExploreImageProvider>(context)
                          .exploreArea[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExploreTemple(),
                                  ),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExploreMall(),
                                  ),
                                );
                                break;
                              case 2:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ExploreAdventure(),
                                  ),
                                );
                                break;
                              case 3:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExploreSchool(),
                                  ),
                                );
                                break;
                              default:
                                break;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            margin: const EdgeInsets.all(15),
                            child: Image.network(
                              explore.imageUrl,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
