import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/*
This class defines the primary button type
@author: Ugochukwu Umeh
*/
class PrimaryButton extends StatelessWidget {
  ///The margin of the button
  final EdgeInsetsGeometry? fMargin;

  ///The padding of the button.
  /// Defaults to
  /// ```dart
  /// EdgeInsets.symmetric(
  ///   horizontal: 16,
  ///   vertical: fBigButton ? 10 : 8,
  /// ),
  /// ```
  final EdgeInsetsGeometry? fPadding;

  /// Function when button is tapped
  final VoidCallback fOnTap;

  ///Overflow
  final TextOverflow? fTextOverflow;

  ///Button text
  final String fText;

  ///Checks if button is enabled. Defaults to true
  final bool fEnabled;

  ///The button text size. Defaults to 15
  final double fTextSize;

  ///The font weight. Defaults to semi-bold
  final FontWeight fFontWeight;

  ///The border decoration
  final Border? fBorder;

  ///The background color of the button. Defaults to the blue color when
  ///enabled and grey when not enabled
  final Color? fBackgroundColor;

  ///The border radius of the button edges. Defaults to 4
  final double fButtonRadius;

  ///A big button is one with more vertical padding. It uses a vertical padding
  ///of 10
  final bool fBigButton;

  /// The color of the text
  final Color? fTextColor;

  /// If the text should be clamped. Mostly used in app bars and defaults to false
  final bool fShouldClamp;

  /// The constraints
  final BoxConstraints? fBoxConstraints;

  /// The maximum number of lines for the text
  final int? fMaxLines;

  /// semantic label
  final String? fSemanticLabel;

  ///Creates a primary button with [fOnTap] function and [fText].
  ///
  /// [fEnabled] determines when the button should be responsive to tap and
  /// [fShouldClamp] allows the [fText] to be clamped. For [fTextSize]
  /// don't use scaling as that is already here.
  ///By default [fEnabled] is true, [fTextSize]
  ///is 15.
  const PrimaryButton({
    super.key,
    this.fMargin,
    this.fPadding,
    this.fEnabled = true,
    this.fTextSize = 15,
    this.fTextOverflow,
    this.fFontWeight = FontWeight.w600,
    this.fBackgroundColor,
    required this.fOnTap,
    required this.fText,
    this.fBorder,
    this.fButtonRadius = 4,
    this.fBigButton = false,
    this.fTextColor,
    this.fShouldClamp = false,
    this.fBoxConstraints,
    this.fMaxLines,
    this.fSemanticLabel,
  });

  /// This uses a padding of 16 horizontal and 10 vertical to style the button
  const PrimaryButton.big({
    super.key,
    this.fMargin,
    this.fEnabled = true,
    this.fTextSize = 15,
    this.fTextOverflow,
    this.fFontWeight = FontWeight.w600,
    this.fBackgroundColor,
    required this.fOnTap,
    required this.fText,
    this.fBorder,
    this.fButtonRadius = 6,
    this.fTextColor,
    this.fShouldClamp = false,
    this.fBoxConstraints,
    this.fMaxLines,
    this.fSemanticLabel,
  })  : fPadding = const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        fBigButton = false;

  /// This uses a padding of 16 horizontal and 8 vertical to style the button.
  /// Used primarily in the app bar
  const PrimaryButton.appBar({
    super.key,
    this.fMargin,
    this.fEnabled = true,
    this.fTextSize = 15,
    this.fTextOverflow,
    this.fFontWeight = FontWeight.w600,
    this.fBackgroundColor,
    required this.fOnTap,
    required this.fText,
    this.fBorder,
    this.fButtonRadius = 4,
    this.fTextColor,
    this.fShouldClamp = false,
    this.fBoxConstraints,
    this.fMaxLines,
    this.fSemanticLabel,
  })  : fPadding = const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        fBigButton = false;

  @override
  Widget build(BuildContext context) {
    /// The color of the button
    final Color fColor = fEnabled
        ? fBackgroundColor ?? context.colors.secondary
        : context.colors.tertiary.withOpacity(0.3);

    return Semantics(
      label: fSemanticLabel ?? fText,
      button: true,
      enabled: fEnabled,
      excludeSemantics: true,
      child: Container(
        margin: fMargin ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: fColor,
          borderRadius: BorderRadius.circular(fButtonRadius),
          border: fBorder,
        ),
        clipBehavior: Clip.hardEdge,
        constraints: fBoxConstraints,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: context.colors.surface.withOpacity(0.2),
            highlightColor: context.colors.surface.withOpacity(0.2),
            onTap: fEnabled ? fOnTap : null,
            child: Padding(
              padding: fPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: fBigButton ? 10 : 8,
                  ),
              child: MediaQuery.withClampedTextScaling(
                maxScaleFactor: fShouldClamp ? 1.5 : double.infinity,
                child: Text(
                  fText,
                  textAlign: TextAlign.center,
                  overflow: fTextOverflow,
                  maxLines: fMaxLines,
                  style: TextStyle(
                    fontSize: fTextSize,
                    color: fTextColor ?? context.colors.onSecondary,
                    fontWeight: fFontWeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
This class defines the outline primary button type
@author: Ugochukwu Umeh
*/
class OutlinePrimaryButton extends StatelessWidget {
  ///The margin of the button
  final EdgeInsetsGeometry? fMargin;

  ///The padding of the button
  final EdgeInsetsGeometry? fPadding;

  /// The button bg color
  final Color? fButtonBackground;

  /// Blend background with boarder
  final bool? fBlendBackgroundWithBorder;

  ///Function when button is tapped
  final VoidCallback? fOnTap;

  ///Text overflow
  final TextOverflow? fTextOverflow;

  ///Button text
  final String fText;

  ///The button text size. Defaults to 15
  final double fTextSize;

  ///The font weight. Defaults to semi-bold
  final FontWeight fFontWeight;

  ///The text color.
  final Color fTextColor;

  ///The border radius of the button edges. Defaults to 8
  final double fButtonRadius;

  ///A big button is one with more vertical padding. It uses a vertical padding
  ///of 10
  final bool fBigButton;

  /// If the text should be clamped. Mostly used in app bars and defaults to false
  final bool fShouldClamp;

  /// Semantic label
  final String? fSemanticLabel;

  ///Creates a primary button with [fOnTap] function and [fText].
  ///
  /// [fShouldClampText] allows the [fText] to be clamped. For [fTextSize]
  ///don't use scaling as that is already here.
  ///By default [fShouldClamp] is false.
  const OutlinePrimaryButton({
    super.key,
    this.fMargin,
    this.fPadding,
    this.fTextSize = 15,
    this.fFontWeight = FontWeight.w600,
    this.fTextOverflow,
    required this.fTextColor,
    required this.fOnTap,
    required this.fText,
    this.fButtonRadius = 4,
    this.fBlendBackgroundWithBorder,
    this.fButtonBackground,
    this.fBigButton = false,
    this.fShouldClamp = false,
    this.fSemanticLabel,
  });

  /// This uses a padding of 16 horizontal and 10 vertical to style the button
  const OutlinePrimaryButton.big({
    super.key,
    required this.fOnTap,
    required this.fText,
    required this.fTextColor,
    this.fMargin,
    this.fTextSize = 15,
    this.fTextOverflow,
    this.fFontWeight = FontWeight.w600,
    this.fButtonRadius = 6,
    this.fShouldClamp = false,
    this.fButtonBackground,
    this.fBlendBackgroundWithBorder,
    this.fSemanticLabel,
  })  : fPadding = const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        fBigButton = false;

  /// This uses a padding of 16 horizontal and 8 vertical to style the button.
  /// Used primarily in the app bar
  const OutlinePrimaryButton.appBar({
    super.key,
    required this.fOnTap,
    required this.fText,
    required this.fTextColor,
    this.fMargin,
    this.fTextSize = 15,
    this.fTextOverflow,
    this.fFontWeight = FontWeight.w600,
    this.fButtonRadius = 4,
    this.fShouldClamp = false,
    this.fButtonBackground,
    this.fBlendBackgroundWithBorder,
    this.fSemanticLabel,
  })  : fPadding = const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        fBigButton = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: fSemanticLabel ?? fText,
      button: true,
      excludeSemantics: true,
      child: Container(
        margin: fMargin ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: fButtonBackground,
          border: Border.all(
            color: fBlendBackgroundWithBorder == true
                ? fButtonBackground == null
                    ? fTextColor
                    : fButtonBackground!
                : fTextColor,
          ),
          borderRadius: BorderRadius.circular(fButtonRadius),
        ),
        clipBehavior: Clip.hardEdge,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: fTextColor.withOpacity(0.2),
            highlightColor: fTextColor.withOpacity(0.2),
            onTap: fOnTap,
            child: Padding(
              padding: fPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: fBigButton ? 10 : 8,
                  ),
              child: MediaQuery.withClampedTextScaling(
                maxScaleFactor: fShouldClamp ? 1.5 : double.infinity,
                child: Text(
                  fText,
                  textAlign: TextAlign.center,
                  overflow: fTextOverflow,
                  style: TextStyle(
                    fontSize: fTextSize,
                    color: fTextColor,
                    fontWeight: fFontWeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
The custom text button
@author: Ugochukwu Umeh
 */
class TextPrimaryButton extends StatelessWidget {
  final Color? fSplashColor;
  final Widget fChild;
  final EdgeInsetsGeometry? fPadding;
  final VoidCallback? fOnTap;
  final double fBorderRadius;
  final EdgeInsetsGeometry? fMargin;
  final String? fSemanticLabel;

  /// Creates a text button using inkwell for tap detection. It uses a default
  /// padding of 8 all round and a default splash color of tertiary.
  /// Also uses a border radius of 4
  const TextPrimaryButton({
    super.key,
    required this.fChild,
    this.fOnTap,
    this.fSplashColor,
    this.fPadding,
    this.fBorderRadius = 4,
    this.fMargin,
    this.fSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = fSplashColor?.withOpacity(0.1) ??
        context.colors.tertiary.withOpacity(0.1);
    final EdgeInsetsGeometry padding = fPadding ?? const EdgeInsets.all(8);
    final EdgeInsetsGeometry margin = fMargin ?? EdgeInsets.zero;
    return Semantics(
      label: fSemanticLabel,
      button: true,
      excludeSemantics: fSemanticLabel != null,
      child: Padding(
        padding: margin,
        child: InkWell(
          onTap: fOnTap,
          splashColor: color,
          highlightColor: color,
          borderRadius: BorderRadius.circular(fBorderRadius),
          child: Padding(
            padding: padding,
            child: fChild,
          ),
        ),
      ),
    );
  }
}

/*
The custom icon button
@author: Ugochukwu Umeh
 */
class PrimaryIconButton extends StatelessWidget {
  final Widget fIcon;
  final Color? fSplashColor;

  /// Defaults to 8 on all sides
  final EdgeInsetsGeometry? fPadding;

  /// Defaults to BorderRadius.circular(30)
  final BorderRadius? fBorderRadius;
  final VoidCallback? fOnTap;

  final String? fSemanticLabel;

  const PrimaryIconButton({
    super.key,
    required this.fIcon,
    this.fSemanticLabel,
    this.fSplashColor,
    this.fPadding,
    this.fOnTap,
    this.fBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius fRadius = fBorderRadius ?? BorderRadius.circular(30);
    return Semantics(
      button: true,
      label: fSemanticLabel,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        borderRadius: fRadius,
        child: InkWell(
          splashColor: fSplashColor,
          onTap: fOnTap,
          borderRadius: fRadius,
          child: Padding(
            padding: fPadding ?? const EdgeInsets.all(8),
            child: fIcon,
          ),
        ),
      ),
    );
  }
}

/// A custom button widget with a gradient background.
///
/// This button is highly customizable and follows Material Design standards.
/// - Supports custom shapes, gradients, and border radii.
/// - Encapsulates an `ElevatedButton` for handling interactions.
///
/// Usage:
/// ```dart
/// PrimaryGradientButton(
///   fOnPressed: () => print('Pressed'),
///   fChild: Text('Click Me'),
///   fGradientColors: [Colors.purple, Colors.pink, Colors.orange],
///   fBorderRadius: BorderRadius.circular(20),
/// )
/// ```
/// author: Godwin Mathias
class PrimaryGradientButton extends StatelessWidget {
  /// The callback function triggered when the button is pressed.
  final VoidCallback? fOnPressed;

  /// The widget to display inside the button (e.g., Text or Icon).
  final Widget fChild;

  /// The colors for the gradient background of the button.
  final List<Color> fGradientColors;

  /// The height of the button
  final double fHeight;

  /// The width of the button
  final double fWidth;

  /// The border radius for the button's corners.
  ///
  /// Defaults to `BorderRadius.circular(30)` if not provided.
  final BorderRadius? fBorderRadius;

  /// The shape of the button's background.
  ///
  /// Can be a rectangle, circle, etc. Defaults to `BoxShape.rectangle`.
  final BoxShape? fShape;

  /// Indicate if button is disabled
  final bool fDisabled;

  /// Creates a `PrimaryGradientButton`.
  ///
  /// Requires:
  /// - [fOnPressed] to define the button's interaction behavior.
  /// - [fChild] to display the button's content.
  /// - [fGradientColors] to specify the gradient colors.
  const PrimaryGradientButton({
    super.key,
    required this.fOnPressed,
    required this.fChild,
    this.fGradientColors = const [],
    this.fDisabled = false,
    this.fBorderRadius,
    this.fShape,
    this.fHeight = 56,
    this.fWidth = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      /// Define the button's base style.
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: context.colors.primary,
      ).copyWith(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),

          /// Override button's elevation to remove default shadow.
          elevation: WidgetStateProperty.all(0),

          /// Define a transparent border to avoid visual noise.
          side: WidgetStateProperty.all(
            const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),

          /// Set the shape of the button
          shape: WidgetStateProperty.all(
            fShape == BoxShape.circle ? const CircleBorder() : null,
          )),
      onPressed: fDisabled ? null : fOnPressed,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 30,
          maxHeight: fHeight,
          maxWidth: fWidth,
        ),
        child: Ink(
          /// Use `Ink` for the gradient background.
          decoration: BoxDecoration(
            /// Set the shape of the button.
            shape: fShape ?? BoxShape.rectangle,

            /// Apply a linear gradient for the background.
            gradient: fDisabled
                ? null
                : LinearGradient(
                    stops: const [
                      0.1,
                      0.3,
                      0.7,
                    ],
                    colors: fGradientColors.isEmpty
                        ? AppColor.fPrimaryGradient
                        : fGradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

            /// Define the corner radius.
            borderRadius: fShape != BoxShape.circle
                ? fBorderRadius ?? BorderRadius.circular(30)
                : null,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            /// Center-align the content inside the button.
            alignment: Alignment.center,

            /// Add the child widget (e.g., Text or Icon).
            child: DefaultTextStyle.merge(
              style: context.appTextTheme.buttonLarge?.copyWith(
                color: Colors.white,
              ),
              child: fChild,
            ),
          ),
        ),
      ),
    );
  }
}
