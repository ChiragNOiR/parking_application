// import 'package:flutter/material.dart';
// import 'package:parking_app/features/profile/domain/user.dart';

// import '../infrastructure/user_service.dart';

// // class UserModel extends ChangeNotifier {
// //   // final String? userId;
// //   // final String? fullName;
// //   // final String? email;
// //   // final String? phone;
// //   // final String? address;

// //   // UserModel({
// //   //   required this.fullName,
// //   //   required this.email,
// //   //   required this.phone,
// //   //   required this.address,
// //   //   required this.userId,
// //   // });

// //   // factory UserModel.fromJson(Map<String, dynamic> json) {
// //   //   return UserModel(
// //   //     userId: json['_id'],
// //   //     fullName: json['fullName'] ?? "",
// //   //     email: json['email'] ?? "",
// //   //     address: json['address'] ?? "",
// //   //     phone: json['contact'] ?? "",
// //   //   );
// //   // }
// // }

// enum HomeState {
//   Initial,
//   Loading,
//   Loaded,
//   Error,
// }

// class UserModel extends ChangeNotifier {
//   HomeState _homeState = HomeState.Initial;
//   List<User> users = [];
//   String message = '';

//   UserModel() {
//     _fetchUsers();
//   }

//   HomeState get homeState => _homeState;

//   Future<void> _fetchUsers() async {
//     _homeState = HomeState.Loading;
//     try {
//       await Future.delayed(Duration(seconds: 5));
//       final apiusers = await UserApi.instance.getAllUser();
//       users = apiusers;
//       _homeState = HomeState.Loaded;
//     } catch (e) {
//       message = '$e';
//       _homeState = HomeState.Error;
//     }
//     notifyListeners();
//   }
// }
