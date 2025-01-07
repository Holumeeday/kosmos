import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/models/location_model.dart';
import 'package:playkosmos_v3/ui/sign_in_email/cubit/sign_in_cubit.dart';
import 'package:playkosmos_v3/ui/sign_in_phone/cubit/sign_in_phone_cubit.dart';

class LocationManager {
  LocationManager(this._authRemoteApiRepository);
  // Stores the last updated position
  Position? _lastUpdatedPosition;

  // Stream subscription for location updates
  StreamSubscription<Position>? _locationSubscription;

  final AuthRemoteApiRepository _authRemoteApiRepository;

  // Minimum distance (in meters) for a significant location update
  final double significantDistance = 50;

  /// Starts listening to location updates
  void startTracking() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20, // Only trigger if the user moves more than 20 meters
    );

    _locationSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) async {
        try {
          // Check for significant changes
          if (_lastUpdatedPosition == null ||
              _isSignificantChange(_lastUpdatedPosition!, position)) {
            // Update location in the database
            await _authRemoteApiRepository.updateLocation(Locations(
                latitude: position.latitude, longitude: position.longitude));
            // Update the last known position
            _lastUpdatedPosition = position;
          }
        } catch (e) {
          debugPrint('Error updating location: $e');
        }
      },
    );
  }

  /// Stops listening to location updates
  void stopTracking() {
    _locationSubscription?.cancel();
  }

  /// Checks if the new position is significantly different from the last position
  bool _isSignificantChange(Position oldPosition, Position newPosition) {
    double distance = Geolocator.distanceBetween(
      oldPosition.latitude,
      oldPosition.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );

    return distance >
        significantDistance; // Return true if distance exceeds the threshold
  }

  Locations? getCurrentUserLocation(BuildContext context) {
    // Check the `SignInWithEmailCubit` for user location
    final emailLocation =
        context.read<SignInWithEmailCubit>().state.user?.locations;

    // Check the `SignInWithPhoneCubit` for user location
    final phoneLocation =
        context.read<SignInPhoneCubit>().state.user?.locations;

    // Return the first non-null location
    return emailLocation ?? phoneLocation;
  }
}
