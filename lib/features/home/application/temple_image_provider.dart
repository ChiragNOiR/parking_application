import 'dart:collection';

import 'package:flutter/material.dart';

import '../domain/temple_image_model.dart';

class TempleImageProvider extends ChangeNotifier {
  final List<TempleImageModel> _templeImage = [
    TempleImageModel(
      image: 'assets/temple/chandragiri.jpg',
    ),
    TempleImageModel(
      image: 'assets/temple/pashupati.jpg',
    ),
    TempleImageModel(
      image: 'assets/temple/bhaktapur.jpg',
    ),
    TempleImageModel(
      image: 'assets/temple/kathmandu.jpg',
    ),
    TempleImageModel(
      image: 'assets/temple/patan.jpg',
    ),
  ];
  UnmodifiableListView<TempleImageModel> get tempImg {
    return UnmodifiableListView(_templeImage);
  }

  int get imageLength => _templeImage.length;
}
