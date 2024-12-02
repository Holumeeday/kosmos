import 'dart:math';

import 'package:intl/intl.dart';
import 'package:playkosmos_v3/enums/enums.dart';

/// Extension on the double type
extension DoubleExtensions on double {
  ///To get the rating value fixed
  String get ratingFixed => toStringAsFixed(truncateToDouble() == this ? 0 : 1);

  /// To return the device screen enum
  DeviceScreenTypeEnum get deviceScreenType {
    if (this >= 600) {
      return DeviceScreenTypeEnum.tablet;
    }
    return DeviceScreenTypeEnum.mobile;
  }

  /// To convert a double to percent value
  String get toPercentWithoutSign => (this * 100).toStringAsFixed(0);

  /// To convert a double to percent value with the sign
  String get toPercentWithSign => '$toPercentWithoutSign%';

  /// Converting bytes to various units
  String get convertBytesToDataUnits {
    final List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    final exponent = log(this) / log(1024);
    final convertedSize = this / pow(1024, exponent);
    final String formattedSize = NumberFormat(
      '#,###.##',
    ).format(convertedSize);
    return '$formattedSize ${units[exponent.round()]}';
  }
}
