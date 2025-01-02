import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/fonts.gen.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// A collection of custom text styles as defined in the app's design system.
///
/// This class contains predefined [TextStyle] constants for various
/// text elements such as headers, body text, buttons, and captions.
/// It adheres to the design system for consistent typography throughout the app.
///
/// @author: Godwin Mathias
class AppTextStyles {
  /// The largest header style used for main titles or prominent headings.
  ///
  /// - Font size: 32
  /// - Letter spacing: -0.38
  /// - Font weight: Bold (700)
  static const header1 = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 32,
    letterSpacing: -0.38,
    fontWeight: FontWeight.w700,
  );

  /// The second-largest header style for subheadings or section titles.
  ///
  /// - Font size: 28
  /// - Letter spacing: -0.38
  /// - Font weight: Bold (700)
  static const header2 = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 28,
    letterSpacing: -0.38,
    fontWeight: FontWeight.w700,
  );

  /// The third-largest header style for smaller headings or labels.
  ///
  /// - Font size: 14
  /// - Letter spacing: -0.38
  /// - Font weight: Bold (700)
  static const header3 = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 14,
    letterSpacing: -0.38,
    fontWeight: FontWeight.w700,
  );

  /// A standard title style for card titles or form labels.
  ///
  /// - Font size: 18
  /// - Letter spacing: 0
  /// - Font weight: Regular (400)
  static const title = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 18,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  /// The primary body text style for paragraphs or descriptions.
  ///
  /// - Font size: 16
  /// - Letter spacing: 0
  /// - Font weight: Regular (400)
  static const body = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  /// A large button text style for prominent action buttons.
  ///
  /// - Font size: 18
  /// - Letter spacing: 0
  /// - Font weight: Medium (500)
  static const buttonLarge = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 18,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  /// A medium button text style for general action buttons.
  ///
  /// - Font size: 16
  /// - Letter spacing: 0
  /// - Font weight: Medium (500)
  static const buttonMedium = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  /// A small button text style for compact buttons or less prominent actions.
  ///
  /// - Font size: 14
  /// - Letter spacing: 0
  /// - Font weight: Medium (500)
  static const buttonSmall = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  /// A caption text style for hints, tooltips, or less prominent information.
  ///
  /// - Font size: 12
  /// - Letter spacing: 0
  /// - Font weight: Regular (400)
  static const caption = TextStyle(
    fontFamily: FontFamily.dMSans,
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
}

/// A Theme Extension to include custom text styles in the Flutter theme system.
///
/// This enables seamless integration of custom typography with light and dark themes.
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  /// Large display headers, typically used for page titles.
  /// - Font Size: 32
  /// - Letter Spacing: -0.38
  /// - Weight: Bold (w700)
  final TextStyle? header1;

  /// Medium display headers, typically for section titles.
  /// - Font Size: 28
  /// - Letter Spacing: -0.38
  /// - Weight: Bold (w700)
  final TextStyle? header2;

  /// Small display headers, used for subtitles or smaller headings.
  /// - Font Size: 14
  /// - Letter Spacing: -0.38
  /// - Weight: Bold (w700)
  final TextStyle? header3;

  /// Regular titles or prominent labels.
  /// - Font Size: 18
  /// - Letter Spacing: 0
  /// - Weight: Regular (w400)
  final TextStyle? title;

  /// Default body text for paragraphs or descriptions.
  /// - Font Size: 16
  /// - Letter Spacing: 0
  /// - Weight: Regular (w400)
  final TextStyle? body;

  /// Large button text for primary actions.
  /// - Font Size: 18
  /// - Letter Spacing: 0
  /// - Weight: Medium (w500)
  final TextStyle? buttonLarge;

  /// Medium button text for secondary actions.
  /// - Font Size: 16
  /// - Letter Spacing: 0
  /// - Weight: Medium (w500)
  final TextStyle? buttonMedium;

  /// Small button text for tertiary or utility actions.
  /// - Font Size: 14
  /// - Letter Spacing: 0
  /// - Weight: Medium (w500)
  final TextStyle? buttonSmall;

  /// Smallest text for annotations or footnotes.
  /// - Font Size: 12
  /// - Letter Spacing: 0
  /// - Weight: Regular (w400)
  final TextStyle? caption;

  const AppTextTheme({
    this.header1,
    this.header2,
    this.header3,
    this.title,
    this.body,
    this.buttonLarge,
    this.buttonMedium,
    this.buttonSmall,
    this.caption,
  });

  @override
  AppTextTheme copyWith({
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? header3,
    TextStyle? title,
    TextStyle? body,
    TextStyle? buttonLarge,
    TextStyle? buttonMedium,
    TextStyle? buttonSmall,
    TextStyle? caption,
  }) {
    return AppTextTheme(
      header1: header1 ?? this.header1,
      header2: header2 ?? this.header2,
      header3: header3 ?? this.header3,
      title: title ?? this.title,
      body: body ?? this.body,
      buttonLarge: buttonLarge ?? this.buttonLarge,
      buttonMedium: buttonMedium ?? this.buttonMedium,
      buttonSmall: buttonSmall ?? this.buttonSmall,
      caption: caption ?? this.caption,
    );
  }

  @override
  AppTextTheme lerp(ThemeExtension<AppTextTheme>? other, double t) {
    if (other is! AppTextTheme) return this;

    return AppTextTheme(
      header1:
          TextStyle.lerp(header1, other.header1, t) ?? AppTextStyles.header1,
      header2:
          TextStyle.lerp(header2, other.header2, t) ?? AppTextStyles.header2,
      header3:
          TextStyle.lerp(header3, other.header3, t) ?? AppTextStyles.header3,
      title: TextStyle.lerp(title, other.title, t) ?? AppTextStyles.title,
      body: TextStyle.lerp(body, other.body, t) ?? AppTextStyles.body,
      buttonLarge: TextStyle.lerp(buttonLarge, other.buttonLarge, t) ??
          AppTextStyles.buttonLarge,
      buttonMedium: TextStyle.lerp(buttonMedium, other.buttonMedium, t) ??
          AppTextStyles.buttonMedium,
      buttonSmall: TextStyle.lerp(buttonSmall, other.buttonSmall, t) ??
          AppTextStyles.buttonSmall,
      caption:
          TextStyle.lerp(caption, other.caption, t) ?? AppTextStyles.caption,
    );
  }

  static AppTextTheme light = AppTextTheme(
    header1: AppTextStyles.header1.copyWith(color: AppColor.fTextColor),
    header2: AppTextStyles.header2.copyWith(color: AppColor.fTextColor),
    header3: AppTextStyles.header3.copyWith(color: AppColor.fTextColor),
    title: AppTextStyles.title.copyWith(color: AppColor.fTextColor),
    body: AppTextStyles.body.copyWith(color: AppColor.fTextColor),
    buttonLarge: AppTextStyles.buttonLarge.copyWith(color: AppColor.fTextColor),
    buttonMedium:
        AppTextStyles.buttonMedium.copyWith(color: AppColor.fTextColor),
    buttonSmall: AppTextStyles.buttonSmall.copyWith(color: AppColor.fTextColor),
    caption: AppTextStyles.caption.copyWith(color: AppColor.fDarkGrey),
  );

  static AppTextTheme dark = AppTextTheme(
    header1: AppTextStyles.header1.copyWith(color: Colors.white),
    header2: AppTextStyles.header2.copyWith(color: Colors.white),
    header3: AppTextStyles.header3.copyWith(color: Colors.white),
    title: AppTextStyles.title.copyWith(color: Colors.white),
    body: AppTextStyles.body.copyWith(color: Colors.white),
    buttonLarge: AppTextStyles.buttonLarge.copyWith(color: Colors.white),
    buttonMedium: AppTextStyles.buttonMedium.copyWith(color: Colors.white),
    buttonSmall: AppTextStyles.buttonSmall.copyWith(color: Colors.white),
    caption: AppTextStyles.caption.copyWith(color: AppColor.fDarkGrey),
  );
}
