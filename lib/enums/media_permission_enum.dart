import 'package:photo_manager/photo_manager.dart';

/// The enum type when requesting media permission.
///
///  * [common] - Returns permissions for images and videos.
///  * [image] - Returns permissions for images.
///  * [video] - Returns permissions for videos.
enum MediaPermissionEnum {
  image,
  video,
  common;
}

extension MediaPermissionEnumExtension on MediaPermissionEnum {
  // Converts permission enum to request type
  RequestType getRequestType() {
    return switch (this) {
      MediaPermissionEnum.image => RequestType.image,
      MediaPermissionEnum.video => RequestType.video,
      MediaPermissionEnum.common => RequestType.common,
    };
  }
}
