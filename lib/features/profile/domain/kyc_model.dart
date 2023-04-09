// ignore_for_file: public_member_api_docs, sort_constructors_first
class KYCModel {
  String id;
  String userId;
  String name;
  String address;
  String dob;
  String licenseOffice;
  String licenseNumber;
  String citizenNumber;
  String category;
  String contact;
  String doi;
  String doe;
  String status;
  String profile;
  String? licensePhoto;

  KYCModel(
    this.id,
    this.userId,
    this.name,
    this.address,
    this.dob,
    this.licenseOffice,
    this.licenseNumber,
    this.citizenNumber,
    this.category,
    this.contact,
    this.doi,
    this.doe,
    this.status,
    this.profile,
    this.licensePhoto,
  );

  factory KYCModel.fromJson(Map<String, dynamic> json) {
    return KYCModel(
      (json['_id']),
      (json['userId']),
      (json['fullName']),
      (json['address']),
      (json['dateOfBirth']),
      (json['licenseOffice']),
      (json['licenseNumber']),
      (json['citizenshipNumber']),
      (json['category']),
      (json['contact']),
      (json['dateOfIssue']),
      (json['dateOfExpiry']),
      (json['status']),
      (json['profile']),
      (json['licensePhoto']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'fullName': name,
        'address': address,
        'dateOfBirth': dob,
        'licenseOffice': licenseOffice,
        'licenseNumber': licenseNumber,
        'citizenshipNumber': citizenNumber,
        'category': category,
        'contact': contact,
        'dateOfIssue': doi,
        'dateOfExpiry': doe,
        'status': status,
        'profile': profile,
        'licensePhoto': licensePhoto,
      };
}
