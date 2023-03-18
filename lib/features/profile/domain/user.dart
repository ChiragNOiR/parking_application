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
  // String? userProfile;

  User({
    required this.userId,
    required this.fullName,
    required this.userEmail,
    required this.userPassword,
    required this.userContact,
    required this.userAddress,
    required this.token,
    // this.userProfile,
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
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
