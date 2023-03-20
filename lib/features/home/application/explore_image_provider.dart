import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:parking_app/features/home/domain/explore_model.dart';

class ExploreImageProvider extends ChangeNotifier {
  final List<ExploreModel> _exploreArea = [
    ExploreModel(
      name: 'Temple',
      imageUrl:
          'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_627150563_20190822130709_20190822154343.jpg',
    ),
    ExploreModel(
      name: 'Shopping',
      imageUrl:
          'https://www.itourvn.com/images/easyblog_images/2021/january/update_hcm_shopping_malls/aeon-mall-binh-tan-hcm-1.jpg',
    ),
    ExploreModel(
      name: 'Adventure',
      imageUrl:
          'https://whitehilladventure.com/wp-content/uploads/2019/08/IMG_4345-1-995x650.jpg',
    ),
    ExploreModel(
      name: 'School And College',
      imageUrl:
          'https://www.thoughtco.com/thmb/PCVPjqDcfiY4az_kycvn-EJA-e8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/swarthmore-college-Eric-Behrens-flickr-5706ffe35f9b581408d48cb3.jpg',
    ),
  ];

  UnmodifiableListView<ExploreModel> get exploreArea {
    return UnmodifiableListView(_exploreArea);
  }

  int get imageLength => _exploreArea.length;
}
