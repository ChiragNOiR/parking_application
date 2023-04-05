// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationModel {
  String id;
  String title;
  String description;
  String distance;
  String area;
  String slots;
  String image;
  String price;
  String? cover;
  String? des;

  LocationModel(
    this.id,
    this.title,
    this.description,
    this.distance,
    this.area,
    this.slots,
    this.image,
    this.price,
    this.cover,
    this.des,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      (json['_id']),
      (json['title']),
      (json['description']),
      (json['distance']),
      (json['area']),
      (json['slots']),
      (json['image']),
      (json['price']),
      (json['cover']),
      (json['des']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'distance': distance,
        'area': area,
        'slots': slots,
        'image': image,
        'price': price,
        'cover': cover,
        'des': des,
      };
}
