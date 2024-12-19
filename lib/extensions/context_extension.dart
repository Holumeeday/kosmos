import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Context extensions
///
/// Provides utility extensions for `BuildContext` to simplify access to
/// theming, localization, screen dimensions, scaling, platform checks,
/// validation messages, and navigation operations.
/// @author: Godwin Mathias
extension ContextExtension on BuildContext {
  /// Accesses the localized strings.
  AppLocalizations get loc => AppLocalizations.of(this)!;

  /// Accesses the current color scheme.
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Accesses the text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Accesses the custom app text theme.
  AppTextTheme get appTextTheme => Theme.of(this).extension<AppTextTheme>()!;

  /// Accesses the custom app colors.
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  /// Generates a formatted string of interests using localized interest names.
  ///
  /// [playmateInterests] is a list of interest keys to be localized.
  String getPlaymateInterests(List<String> playmateInterests) =>
      playmateInterests
          .map((interest) => loc.setInterestName(interest))
          .join(', ');

  /// Checks if the current platform is iOS or macOS.
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

  /// Gets the current device's screen width.
  double get getDeviceWidth => MediaQuery.sizeOf(this).width;

  /// Gets the current device's screen height.
  double get getDeviceHeight => MediaQuery.sizeOf(this).height;

  /// Checks if the keyboard is not visible.
  bool get isKeyboardNotVisible => MediaQuery.viewInsetsOf(this).bottom == 0;

  /// Scales the height of a widget according to the text scale factor.
  ///
  /// [heightFactor] controls the height-to-font scaling ratio.
  /// [childHeight] specifies the height of the child widget in the design.
  double scaleWithTextFactor(double heightFactor, double childHeight) {
    final textScaleFactor = MediaQuery.textScalerOf(this).scale(1);
    final double unscaledHeight = childHeight;
    final minHeight = unscaledHeight / heightFactor;
    double scaledHeight = unscaledHeight + (textScaleFactor - 1) * minHeight;
    return scaledHeight;
  }

  /// Calculates a percentage of the device height.
  ///
  /// [size] specifies the percentage of the height (e.g., 50, 20, 10).
  double useHeightPercent(double size) => getDeviceHeight * (size / 100);

  /// Calculates a percentage of the device width.
  ///
  /// [size] specifies the percentage of the width (e.g., 50, 20, 10).
  double useWidthPercent(double size) => getDeviceWidth * (size / 100);

  /// Masks the card number, replacing the middle digits with a specified mask.
  ///
  /// [first4Bin] is the first 4 digits of the card number.
  /// [last4Bin] is the last 4 digits of the card number.
  /// [mask] is the character used for masking. Defaults to `'X'`.
  String maskCardNumber({
    required String first4Bin,
    required String last4Bin,
    String mask = 'X',
  }) {
    return '$first4Bin ${mask * 4} ${mask * 4} $last4Bin';
  }
}
