import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/utils/app_colors.dart';

///Context extensions
///
///Holds extensions for the localizations, theming and scaling of text, width and height
///and validation messages
extension ContextExtension on BuildContext {
  /// Localizations
  AppLocalizations get loc => AppLocalizations.of(this)!;

  /// Color Scheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Text Theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// App Colors
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  ///Get the playmate interests
  String getPlaymateInterests(List<String> playmateInterests) =>
      playmateInterests
          .map((interest) => loc.setInterestName(interest))
          .join(', ');

  /// Platform type
  bool isPlatformIos() {
    final ThemeData theme = Theme.of(this);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
    }
  }

  //-------------------------- SCREENUTIL ------------------------------------//
  ///Gets the width
  double get getDeviceWidth => MediaQuery.sizeOf(this).width;

  ///Gets the height
  double get getDeviceHeight => MediaQuery.sizeOf(this).height;

  /// Check if keyboard is not visible
  bool get isKeyboardNotVisible => MediaQuery.viewInsetsOf(this).bottom == 0;

  ///This scales the height of a widget according to the text scale factor
  ///
  ///Adjust [heightFactor] to your desired height-to-font ratio.
  ///[childHeight] from the design
  double scaleWithTextFactor(double heightFactor, double childHeight) {
    final textScaleFactor = MediaQuery.textScalerOf(this).scale(1);
    final double unscaledHeight = childHeight;
    final minHeight = unscaledHeight / heightFactor;
    double scaledHeight = unscaledHeight + (textScaleFactor - 1) * minHeight;
    return scaledHeight;
  }

  ///Gets the height percentage
  ///
  ///[size] is in percent form e.g. 50, 20, 10
  double useHeightPercent(double size) => getDeviceHeight * (size / 100);

  ///Gets the width percentage
  ///
  ///[size] is in percent form e.g. 50, 20, 10
  double useWidthPercent(double size) => getDeviceWidth * (size / 100);

  /// Return the last4 and first4 bin of the card with the masked value replaced
  /// with replacement
  String maskCardNumber({
    required String first4Bin,
    required String last4Bin,
    String mask = 'X',
  }) {
    return '$first4Bin ${mask * 4} ${mask * 4} $last4Bin';
  }
}
