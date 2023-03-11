import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_app/features/profile/domain/user_model.dart';

class UserService {
  Future<List<UserModel>> getUserData() async {
    List<UserModel> user = [];
    try {
      final url = 'http://localhost:3000/getUserDetails';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      // if (response.statusCode == 200) {
      //   final json = jsonDecode(response.body) as List;
      //   final data = json
      //       .map((e) => {
      //             UserModel(
      //               fullName: e['fullName'],
      //               email: e['email'],
      //               phone: e['phone'],
      //               address: e['address'],
      //               userId: e['userId'],
      //             )
      //           })
      //       .toList();
      //   return data;
      // }
      final apiData = jsonDecode(response.body);
      for (var apiData in apiData['success']) {
        if (apiData['fullName'] != null ||
            apiData['email'] != null ||
            apiData['contact'] != null ||
            apiData['address'] != null) {
          UserModel userData = UserModel.fromJson(apiData);
          user.add(userData);
        }
      }
    } catch (e) {
      return user;
    }
    return user;
  }
}
