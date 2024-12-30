import 'dart:convert';

class Locations {
  final double? latitude;
  final double? longitude;

  Locations({
    this.latitude,
    this.longitude,
  });

  Locations copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Locations(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Locations.fromJson(String str) => Locations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Locations.fromMap(Map<String, dynamic> json) => Locations(
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };
}
