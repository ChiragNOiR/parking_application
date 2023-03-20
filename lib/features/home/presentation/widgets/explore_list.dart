// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class ExploreList extends StatelessWidget {
//   const ExploreList({super.key, required this.imageData});
//   final String imageData;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: CachedNetworkImage(
//           imageUrl: imageData,
//           width: 150,
//           height: 200,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }

// class ExploreImageData extends StatelessWidget {
//   const ExploreImageData({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 2,
//       children: List.generate(
//         10,
//         (index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(70),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               margin: EdgeInsets.all(15),
//               child: Image.network(
//                 'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
//                 height: 150,
//                 width: 150,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
