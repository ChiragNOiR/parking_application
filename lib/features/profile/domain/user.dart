// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String userId;
  String fullName;
  String userEmail;
  String userPassword;
  String userContact;
  String token;
  String userAddress;
  String? userProfile;
  String role;

  User({
    required this.userId,
    required this.fullName,
    required this.userEmail,
    required this.userPassword,
    required this.userContact,
    required this.token,
    required this.userAddress,
    this.userProfile,
    required this.role,
  });

  static User empty() {
    return User(
      userId: '',
      fullName: '',
      userEmail: '',
      userPassword: '',
      userContact: '',
      userAddress: '',
      token: '',
      userProfile: '',
      role: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': userId,
      'fullName': fullName,
      'email': userEmail,
      'password': userPassword,
      'contact': userContact,
      'address': userAddress,
      'token': token,
      'profile': userProfile,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      userEmail: map['email'] ?? '',
      userPassword: map['password'] ?? '',
      userContact: map['contact'] ?? '',
      userAddress: map['address'] ?? '',
      token: map['token'] ?? '',
      userProfile: map['profile'] ?? '',
      role: map['role'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
