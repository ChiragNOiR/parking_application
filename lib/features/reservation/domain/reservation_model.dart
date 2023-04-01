class ReservationModel {
  String id;
  String userName;
  String address;
  String? company;
  String contact;
  String location;
  String price;
  String start;
  String end;

  ReservationModel(
    this.id,
    this.userName,
    this.address,
    this.company,
    this.contact,
    this.location,
    this.price,
    this.start,
    this.end,
  );

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      (json['_id']),
      (json['fullName']),
      (json['address']),
      (json['company']),
      (json['location']),
      (json['contact']),
      (json['price']),
      (json['startTime']),
      (json['endTime']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullName': userName,
        'address': address,
        'company': company,
        'contact': contact,
        'location': location,
        'price': price,
        'startTime': start,
        'endTime': end,
      };
}
