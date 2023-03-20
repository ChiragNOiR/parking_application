import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/explore/presentation/explore_screen.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_adventure.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_mall.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_schools.dart';
import 'package:parking_app/features/explore/presentation/explore_screens/explore_temple.dart';
import 'package:parking_app/features/home/application/explore_image_provider.dart';
import 'package:parking_app/features/home/domain/explore_model.dart';
import 'package:parking_app/features/home/presentation/widgets/drawer.dart';
import 'package:parking_app/features/home/presentation/widgets/explore_list.dart';
import 'package:parking_app/features/home/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/divider_text.dart';
import '../../../core/shared/parking_list.dart';

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
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  //   email = jwtDecodedToken['email'];
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: NavDrawer(),
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
                  const HomeSearchBar(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const DividerText(text: 'NEARBY'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF11D195),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ParkingListTile(
                            image:
                                Image.asset('assets/images/parking_logo.png'),
                            title: 'Park Hero',
                            subtitle: '00 Slots Available',
                            trailing: '500 m',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const DividerText(text: 'EXPLORE'),
              ),
              Container(
                height: 410,
                // child: ListView.builder(
                //   // shrinkWrap: true,
                //   itemCount: 4,
                //   scrollDirection: Axis.vertical,
                //   itemBuilder: (context, index) {
                //     return Row(
                //       children: [
                //         SizedBox(
                //           width: 20,
                //         ),
                //         const ExploreList(
                //           imageData:
                //               'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                //         ),
                //         SizedBox(
                //           width: 20,
                //         ),
                //         const ExploreList(
                //           imageData:
                //               'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                //         )
                //       ],
                //     );
                //   },
                // ),
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
                                    builder: (context) => ExploreTemple(),
                                  ),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExploreMall(),
                                  ),
                                );
                                break;
                              case 2:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExploreAdventure(),
                                  ),
                                );
                                break;
                              case 3:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExploreSchool(),
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
                            margin: EdgeInsets.all(15),
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
