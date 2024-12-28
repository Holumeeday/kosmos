import 'package:geolocator/geolocator.dart';

class LocationUtil {
  /// The function to get a user location.
  ///
  /// This also checks if the location permission is granted and services are
  /// enabled
  static Future<Position?> getLocation() async {
    try {
      // If its true then get the current location and move to the choose
      // location screen
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      rethrow;
    }
  }
}
