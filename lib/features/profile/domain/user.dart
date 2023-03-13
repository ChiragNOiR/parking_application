// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// class User {
//   String? id;
//   String? fullName;
//   String? email;
//   String? contact;
//   String? address;

//   User({
//     this.id,
//     this.fullName,
//     this.email,
//     this.contact,
//     this.address,
//   });

//   User.fromJson(Map<String, dynamic> json) {
//     id:
//     json['_id'];
//     fullName:
//     json['fullName'];
//     email:
//     json['email'];
//     address:
//     json['address'];
//     phone:
//     json['contact'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['_id'] = this.id.toString();
//     data['fullName'] = this.fullName;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['contact'] = this.contact;

//     return data;
//   }
// }

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

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     (json['_id']),
  //     (json['fullName']),
  //     (json['email']),
  //     (json['password']),
  //     (json['contact']),
  //     (json['address']),
  //     // (json['profile']),
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       '_id': userId,
  //       'fullName': fullName,
  //       'email': userEmail,
  //       'password': userPassword,
  //       // 'profile': userProfile,
  //       'contact': userContact,
  //       'address': userAddress,
  //     };

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
      userEmail: map['userEmail'] ?? '',
      userPassword: map['userPassword'] ?? '',
      userContact: map['userContact'] ?? '',
      userAddress: map['userAddress'] ?? '',
      token: map['token'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
