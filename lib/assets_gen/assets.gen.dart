/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// Directory path: assets/pngs/onboarding
  $AssetsPngsOnboardingGen get onboarding => const $AssetsPngsOnboardingGen();
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// Directory path: assets/svgs/auth
  $AssetsSvgsAuthGen get auth => const $AssetsSvgsAuthGen();

  /// Directory path: assets/svgs/branding
  $AssetsSvgsBrandingGen get branding => const $AssetsSvgsBrandingGen();

  /// Directory path: assets/svgs/flags
  $AssetsSvgsFlagsGen get flags => const $AssetsSvgsFlagsGen();
}

class $AssetsPngsOnboardingGen {
  const $AssetsPngsOnboardingGen();

  /// File path: assets/pngs/onboarding/create-onboarding.png
  AssetGenImage get createOnboarding =>
      const AssetGenImage('assets/pngs/onboarding/create-onboarding.png');

  /// File path: assets/pngs/onboarding/earn-onboarding.png
  AssetGenImage get earnOnboarding =>
      const AssetGenImage('assets/pngs/onboarding/earn-onboarding.png');

  /// File path: assets/pngs/onboarding/meet-onboarding.png
  AssetGenImage get meetOnboarding =>
      const AssetGenImage('assets/pngs/onboarding/meet-onboarding.png');

  /// File path: assets/pngs/onboarding/stay-connected-onboarding.png
  AssetGenImage get stayConnectedOnboarding => const AssetGenImage(
      'assets/pngs/onboarding/stay-connected-onboarding.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        createOnboarding,
        earnOnboarding,
        meetOnboarding,
        stayConnectedOnboarding
      ];
}

class $AssetsSvgsAuthGen {
  const $AssetsSvgsAuthGen();

  /// File path: assets/svgs/auth/email-gradient.svg
  SvgGenImage get emailGradient =>
      const SvgGenImage('assets/svgs/auth/email-gradient.svg');

  /// File path: assets/svgs/auth/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svgs/auth/google.svg');

  /// File path: assets/svgs/auth/phone-gradient.svg
  SvgGenImage get phoneGradient =>
      const SvgGenImage('assets/svgs/auth/phone-gradient.svg');

  /// File path: assets/svgs/auth/playkosmos-logo-vertical-transparent.svg
  SvgGenImage get playkosmosLogoVerticalTransparent => const SvgGenImage(
      'assets/svgs/auth/playkosmos-logo-vertical-transparent.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [emailGradient, google, phoneGradient, playkosmosLogoVerticalTransparent];
}

class $AssetsSvgsBrandingGen {
  const $AssetsSvgsBrandingGen();

  /// File path: assets/svgs/branding/logo-colored-bg.svg
  SvgGenImage get logoColoredBg =>
      const SvgGenImage('assets/svgs/branding/logo-colored-bg.svg');

  /// File path: assets/svgs/branding/logo-text.svg
  SvgGenImage get logoText =>
      const SvgGenImage('assets/svgs/branding/logo-text.svg');

  /// File path: assets/svgs/branding/logo-white-bg.svg
  SvgGenImage get logoWhiteBg =>
      const SvgGenImage('assets/svgs/branding/logo-white-bg.svg');

  /// List of all assets
  List<SvgGenImage> get values => [logoColoredBg, logoText, logoWhiteBg];
}

class $AssetsSvgsFlagsGen {
  const $AssetsSvgsFlagsGen();

  /// File path: assets/svgs/flags/cn_flag.svg
  SvgGenImage get cnFlag => const SvgGenImage('assets/svgs/flags/cn_flag.svg');

  /// File path: assets/svgs/flags/fi_flag.svg
  SvgGenImage get fiFlag => const SvgGenImage('assets/svgs/flags/fi_flag.svg');

  /// File path: assets/svgs/flags/fr_flag.svg
  SvgGenImage get frFlag => const SvgGenImage('assets/svgs/flags/fr_flag.svg');

  /// File path: assets/svgs/flags/gb_flag.svg
  SvgGenImage get gbFlag => const SvgGenImage('assets/svgs/flags/gb_flag.svg');

  /// File path: assets/svgs/flags/in_flag.svg
  SvgGenImage get inFlag => const SvgGenImage('assets/svgs/flags/in_flag.svg');

  /// File path: assets/svgs/flags/lk_flag.svg
  SvgGenImage get lkFlag => const SvgGenImage('assets/svgs/flags/lk_flag.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [cnFlag, fiFlag, frFlag, gbFlag, inFlag, lkFlag];
}

class Assets {
  Assets._();

  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = true;

  final String _assetName;

  final Size? size;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture(
      _isVecFormat
          ? AssetBytesLoader(_assetName,
              assetBundle: bundle, packageName: package)
          : SvgAssetLoader(_assetName,
              assetBundle: bundle, packageName: package),
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
