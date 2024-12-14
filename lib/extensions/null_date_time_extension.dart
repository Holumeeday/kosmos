import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// DateTime? extensions
extension NullDateTimeExtension on DateTime? {
  AppLocalizations get _loc => GetContext.loc;

  /// Converts the datetime to any pattern you want string
  String? convertToString(String pattern) {
    if (this == null) {
      return null;
    }
    return DateFormat(pattern, _loc.localeName).format(this!);
  }

  /// To know how much time has passed since a post or notification was made
  ///
  /// Less than a minute => (secondsDiff) seconds ago
  /// Less than an hour => (minuteDiff) mins ago
  /// Less than a week => (dayDiff) days ago
  /// => (weeksDiff) wks ago
  String postNotificationTimePassed() {
    if (this == null) {
      return '';
    }
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this!);
    if (difference.inSeconds < 60) {
      return _loc.justNow;
    } else if (difference.inMinutes < 60) {
      return _loc.nMinAgoShort(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return _loc.nHrsAgoShort(difference.inHours);
    } else if (difference.inDays < 7) {
      return _loc.nDaysAgoShort(difference.inDays);
    } else {
      final int weeks = difference.inDays ~/ 7;
      return _loc.nWeeksAgoShort(weeks);
    }
  }

  /// Converts a date time to dd/MM/yyyy format if not null
  /// else returns an empty string
  String get convertToDateMonthYear {
    if (this == null) {
      return '';
    }
    return convertToString('yMd').checkNull;
  }

  /// Converts to string
  String get convertToDateHourMinSec {
    if (this == null) return '';
    return this!.year.toString() +
        this!.month.toString() +
        this!.day.toString() +
        this!.hour.toString() +
        this!.minute.toString() +
        this!.second.toString();
  }

  /// Convert to locale string
  String? convertToLocaleString() {
    if (this == null) {
      return null;
    }
    return DateFormat.jm(_loc.localeName).format(this!);
  }

  /// Converts time of day to its string form i.e. hh:mm am or pm
  String? getTimeZoneOffset() {
    if (this == null) {
      return null;
    }
    final Duration timeZoneOffset = this!.timeZoneOffset;
    final String timeZoneSign = (timeZoneOffset.isNegative) ? '-' : '+';
    final int timeZoneHr = timeZoneOffset.inHours;
    final String timeZoneMins =
        (timeZoneOffset.inMinutes % 60).abs().toString().padLeft(2, '0');
    return '${DateFormat.jm(_loc.localeName).format(this!)} (UTC$timeZoneSign$timeZoneHr:$timeZoneMins)';
  }
}
