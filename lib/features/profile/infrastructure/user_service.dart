import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/features/profile/domain/user_model.dart';
import 'package:toast/toast.dart';

import '../domain/user.dart';

// class UserService {
//   Future<List<UserModel>> getUserData() async {
//     List<UserModel> user = [];
//     try {
//       final url = 'http://localhost:3000/getUserDetails';
//       final uri = Uri.parse(url);
//       final response = await http.get(uri);
//       // if (response.statusCode == 200) {
//       //   final json = jsonDecode(response.body) as List;
//       //   final data = json
//       //       .map((e) => {
//       //             UserModel(
//       //               fullName: e['fullName'],
//       //               email: e['email'],
//       //               phone: e['phone'],
//       //               address: e['address'],
//       //               userId: e['userId'],
//       //             )
//       //           })
//       //       .toList();
//       //   return data;
//       // }
//       final apiData = jsonDecode(response.body);
//       for (var apiData in apiData['success']) {
//         if (apiData['fullName'] != null ||
//             apiData['email'] != null ||
//             apiData['contact'] != null ||
//             apiData['address'] != null) {
//           UserModel userData = UserModel.fromJson(apiData);
//           user.add(userData);
//         }
//       }
//     } catch (e) {
//       return user;
//     }
//     return user;
//   }
// }

// class UserService {
//   Future<UserModel> getUserData(context) async {
//     UserModel result;
//     try {
//       final response = await http.get(
//         Uri.parse(
//           "http://localhost:3000/getUserDetails",
//         ),
//         headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//         },
//       );
//       if (response.statusCode == 200) {
//         final item = json.decode(response.body);
//         result = UserModel.fromJson(item);
//       } else {
//         Toast.show("Data not found",
//             duration: 2, backgroundColor: Colors.redAccent);
//       }
//     } catch (e) {
//       print(e);
//     }
//     return result;
//   }
// }

// class UserApi {
//   static late UserApi _instance;

//   UserApi._();

//   static UserApi get instance {
//     if (_instance == null) {
//       _instance = UserApi._();
//     }
//     return _instance;
//   }

//   Future<List<User>> getAllUser() async {
//     final getUser = await http
//         .get(Uri.parse("http://10.0.2.2:3000/getUserDetails"), headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//     });
//     final List responseBody = jsonDecode(getUser.body);
//     return responseBody.map((e) => User.fromJson(e)).toList();
//   }
// }
