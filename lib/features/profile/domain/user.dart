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

  String userAddress;

  String? userProfile;

  User(
    this.userId,
    this.fullName,
    this.userEmail,
    this.userPassword,
    this.userContact,
    this.userAddress,
    this.userProfile,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      (json['_id']),
      (json['fullName']),
      (json['email']),
      (json['password']),
      (json['contact']),
      (json['address']),
      (json['profile']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': userId,
        'fullName': fullName,
        'email': userEmail,
        'password': userPassword,
        'profile': userProfile,
        'contact': userContact,
        'address': userAddress,
      };
}
