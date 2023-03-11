import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phone: json['contact'] as String,
    );
  }
}
