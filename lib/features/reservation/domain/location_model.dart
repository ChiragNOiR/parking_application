class LocationModel {
  String id;
  String title;
  String description;
  String distance;
  String area;
  String slots;

  LocationModel(
    this.id,
    this.title,
    this.description,
    this.distance,
    this.area,
    this.slots,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      (json['_id']),
      (json['title']),
      (json['description']),
      (json['distance']),
      (json['area']),
      (json['slots']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'distance': distance,
        'area': area,
        'slots': slots,
      };
}
