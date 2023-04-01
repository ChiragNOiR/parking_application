// ignore_for_file: public_member_api_docs, sort_constructors_first
class VehicleModel {
  String id;
  String company;
  String model;
  String year;
  String color;
  String licenseNumber;
  String stateOfRegistration;

  VehicleModel(
    this.id,
    this.company,
    this.model,
    this.year,
    this.color,
    this.licenseNumber,
    this.stateOfRegistration,
  );

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      (json['_id']),
      (json['company']),
      (json['model']),
      (json['year']),
      (json['color']),
      (json['licenseNumber']),
      (json['stateOfRegistration']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'company': company,
        'model': model,
        'year': year,
        'color': color,
        'licenseNumber': licenseNumber,
        'stateOfRegistration': stateOfRegistration,
      };
}
