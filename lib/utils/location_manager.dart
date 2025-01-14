import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/models/location_model.dart';

class LocationManager {
  LocationManager(this._authRemoteApiRepository, this._permissionsRepository);
  Position? _lastUpdatedPosition;
  StreamSubscription<Position>? _locationSubscription;
  final AuthRemoteApiRepository _authRemoteApiRepository;
  final PermissionsRepository _permissionsRepository;
  Position? _position;
  final double significantDistance = 50;

  /// Starts location tracking with a live position stream.
  void startTracking() async {
    try {
    /// Check and request location permissions
       final fIsPermitted =
        await _permissionsRepository.requestLocationPermission();
      if (fIsPermitted != true) return;

      _position = await _handleLocationUpdate(_position);

      await _authRemoteApiRepository.updateLocation(Locations(
        latitude: _position?.latitude,
        longitude: _position?.longitude,
      ));

      debugPrint('Location tracking started.');
    } catch (e) {
      debugPrint('Error starting location tracking: $e');
    }
  }

  /// Gets the current user location once.
  Future<Locations?> getCurrentUserLocation() async {
    try {
      /// Check and request location permissions
       final fIsPermitted =
        await _permissionsRepository.requestLocationPermission();
      if (fIsPermitted != true) return null;

      _position = await _handleLocationUpdate(_position);
      return Locations(
        latitude: _position?.latitude,
        longitude: _position?.longitude,
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }

  /// Stops the live location tracking.
  void stopTracking() {
    _locationSubscription?.cancel();
  }

  /// Handles location updates by comparing with the last position
  /// and updating the server if the change is significant.
  Future<Position?> _handleLocationUpdate(Position? position) async {
    try {
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 20,
      );
      _locationSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((position) {
        if (_lastUpdatedPosition == null ||
            _isSignificantChange(_lastUpdatedPosition!, position)) {
          log('###### Updating location: $_lastUpdatedPosition -> $position');

          _lastUpdatedPosition = position;
        }
      });
          log('###### Returning location: $_lastUpdatedPosition ');

      return _lastUpdatedPosition;
    } catch (e) {
      debugPrint('Error handling location update: $e');
    }
    return null;
  }



  /// Determines whether the change in position is significant.
  bool _isSignificantChange(Position oldPosition, Position newPosition) {
    double distance = Geolocator.distanceBetween(
      oldPosition.latitude,
      oldPosition.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );
    return distance > significantDistance;
  }
}
