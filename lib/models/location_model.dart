class Locations {
  final double? latitude;
  final double? longitude;

  const Locations({
    this.latitude=6.531320,
    this.longitude=3.324550,
  });

  // Factory constructor for creating an instance from a JSON Map
  factory Locations.fromMap(Map<String, dynamic> json) => Locations(
        latitude: _parseDouble(json['latitude']),
        longitude: _parseDouble(json['longitude']),
      );

  // Converts the instance to a JSON Map
  Map<String, dynamic> toMap() => {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };

  // Helper method to safely parse a value to double
  static double? _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null; // Fallback for unexpected types
  }

  // Returns a new instance with updated fields
  Locations copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Locations(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
