// ignore_for_file: public_member_api_docs, sort_constructors_first
class HistoryModel {
  String userId;
  String fullName;
  String contact;
  String location;
  String price;
  String startTime;
  String endTime;
  String date;

  HistoryModel(
    this.userId,
    this.fullName,
    this.contact,
    this.location,
    this.price,
    this.startTime,
    this.endTime,
    this.date,
  );

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      (json['userId']),
      (json['fullName']),
      (json['contact']),
      (json['location']),
      (json['price']),
      (json['startTime']),
      (json['endTime']),
      (json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'contact': contact,
        'location': location,
        'price': price,
        'startTime': startTime,
        'endTime': endTime,
        'date': date,
      };
}
