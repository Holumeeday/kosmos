import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/models/location_model.dart';
import 'package:playkosmos_v3/ui/sign_in_email/cubit/sign_in_cubit.dart';
import 'package:playkosmos_v3/ui/sign_in_phone/cubit/sign_in_phone_cubit.dart';

class LocationManager {
  LocationManager(this._authRemoteApiRepository, this._permissionsRepository);
  Position? _lastUpdatedPosition;
  StreamSubscription<Position>? _locationSubscription;
  final AuthRemoteApiRepository _authRemoteApiRepository;
  final PermissionsRepository _permissionsRepository;

  final double significantDistance = 50;

  void startTracking() async {
    try {
      final fIsPermitted =
          await _permissionsRepository.requestLocationPermission();
      if (fIsPermitted) {
        debugPrint('Location permisions are disabled.');
        return null;
      }
      log("@########### permisions1 $fIsPermitted");
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 20,
      );

      _locationSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position position) async {
          try {
            if (_lastUpdatedPosition == null ||
                _isSignificantChange(_lastUpdatedPosition!, position)) {
              log('###### $_lastUpdatedPosition, $position');
              await _authRemoteApiRepository.updateLocation(Locations(
                  latitude: position.latitude, longitude: position.longitude));
              _lastUpdatedPosition = position;
            }
          } catch (e) {
            debugPrint('Error updating location: $e');
          }
        },
      );

      debugPrint('Location tracking started.');
    } catch (e) {
      debugPrint('Error starting location tracking: $e');
    }
  }

  void stopTracking() {
    _locationSubscription?.cancel();
  }

  bool _isSignificantChange(Position oldPosition, Position newPosition) {
    double distance = Geolocator.distanceBetween(
      oldPosition.latitude,
      oldPosition.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );
    return distance > significantDistance;
  }

  Future<Locations?> getCurrentUserLocation() async {
    try {
      // final fIsPermitted =
      //     await _permissionsRepository.requestLocationPermission();
      // log("@########### permisions $fIsPermitted");

      // if (fIsPermitted) {
      //   debugPrint('Location permisions are disabled.');
      //   return null;
      // }
 bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint(
            'Location permissions are permanently denied. Cannot access location.');
        return null;
      }
      Position position = await Geolocator.getCurrentPosition();

      if (_lastUpdatedPosition == null ||
          _isSignificantChange(_lastUpdatedPosition!, position)) {
        await _authRemoteApiRepository.updateLocation(Locations(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
        _lastUpdatedPosition = position;
      }

      return Locations(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }
}
