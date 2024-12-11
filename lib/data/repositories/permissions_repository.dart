import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This service handles all the use cases for location permission
@author: Ugochukwu Umeh
*/
class PermissionsRepository {
  ///To get the android sdk version for several permission request
  Future<int> _sdkAndroidVersion() async {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }

  ///The permission method itself
  Future<List<Permission>> _getStoragePhotos() async {
    //If its an android phone then it should check the sdk version
    if (Platform.isAndroid) {
      final int deviceSDK = await _sdkAndroidVersion();
      if (deviceSDK <= 32) {
        //Pre API 33 should use storage
        return [Permission.storage];
      } else {
        // Post should use photos and videos
        return [Permission.photos, Permission.videos];
      }
    }
    //if its an ios device then it should use photos
    return [Permission.photos];
  }

  ///To request for permission for photos
  Future<bool> requestMediaStoragePermission(
      {required Future Function() fOnPermanentPermissionDenial}) async {
    /// This gets the appropriate media permission from the different platforms
    /// and sdk version
    final List<Permission> permission = await _getStoragePhotos();

    /// The statuses
    final Map<Permission, PermissionStatus> permissionMap =
        await permission.request();
    final List<PermissionStatus> permissionStatus =
        permissionMap.values.toList();

    /// To apply the permissions
    if (permissionStatus
        .every((element) => element.isGranted || element.isLimited)) {
      return true;
    } else {
      if (permissionStatus.any((element) => element.isPermanentlyDenied)) {
        await fOnPermanentPermissionDenial().then((value) {
          if (value == true) {
            openAppSettings();
          }
        });
      }
      return false;
    }
  }

  /// Determine the current position of the device.
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationServiceDisabledException();
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        throw PermissionPermanentlyDeniedException();
      }
    }

    return true;
  }

  /// Call the camera permission
  Future<bool> requestCameraPermission(
      Future Function() fOnPermanentPermissionDenial) async {
    final PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted || permissionStatus.isLimited) {
      return true;
    } else {
      if (permissionStatus.isPermanentlyDenied) {
        await fOnPermanentPermissionDenial().then((value) {
          if (value == true) {
            openAppSettings();
          }
        });
      }
      return false;
    }
  }

  /// Call the general permission
  Future<void> requestAppWidePermission() async {
    final List<Permission> mediaPermission = await _getStoragePhotos();
    // The app wide permission
    final Map<Permission, PermissionStatus> appPermissions = await [
      Permission.camera,
      Permission.location,
      ...mediaPermission,
    ].request();
    printI(appPermissions);
    return;
  }
}

///This shows a permanently denied exception in cases where its needed
class PermissionPermanentlyDeniedException implements Exception {
  PermissionPermanentlyDeniedException();
}
