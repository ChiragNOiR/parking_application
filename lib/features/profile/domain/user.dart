class User {
  String? id;
  String? fullName;
  String? email;
  String? contact;
  String? address;

  User({
    this.id,
    this.fullName,
    this.email,
    this.contact,
    this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id:
    json['_id'];
    fullName:
    json['fullName'];
    email:
    json['email'];
    address:
    json['address'];
    phone:
    json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['contact'] = this.contact;

    return data;
  }
}
