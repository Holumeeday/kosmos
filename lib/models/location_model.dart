import 'dart:convert';

class Locations {
  final String? latitude;
  final String? longitude;

  Locations({
    this.latitude,
    this.longitude,
  });

  Locations copyWith({
    String? latitude,
    String? longitude,
  }) =>
      Locations(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Locations.fromJson(String str) => Locations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Locations.fromMap(Map<String, dynamic> json) => Locations(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
