import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/core/presentation/theme/text_style.dart';
import 'package:parking_app/features/home/presentation/widgets/drawer.dart';
import 'package:parking_app/features/home/presentation/widgets/explore_list.dart';
import 'package:parking_app/features/home/presentation/widgets/search_bar.dart';

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
              const DividerText(text: 'NEARBY'),
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
              const DividerText(text: 'EXPLORE'),
              Container(
                height: 500,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const ExploreList(
                            imageData:
                                'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                          ),
                          const ExploreList(
                            imageData:
                                'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                          )
                        ],
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
