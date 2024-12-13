import 'package:flutter/material.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/* A custom slider track shape that uses a gradient for the active track
 and supports optional darkening of the inactive track.

 Features:
 - Customizable gradient for the active track.
 - Optional darkening of the inactive track segment.
 - Supports both left-to-right (LTR) and right-to-left (RTL) text directions.

 @author: Chidera Chijama
 */

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Controls whether the inactive track should be darkened.
  final bool dDarkenInactive;

  /// Constructor for the gradient slider track shape.
  const GradientRectSliderTrackShape({
    this.dDarkenInactive = true,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    Offset? secondaryOffset,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    // Validate required slider theme properties.
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(sliderTheme.trackHeight != null && sliderTheme.trackHeight! > 0);

    // Gradient definition for the active track.
    const kGradient = LinearGradient(
      stops: [
        0.6,
        0.8,
        0.9,
      ],
      colors: AppColor.fPrimaryGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Get the preferred rectangle for the slider track.
    final Rect fTrackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Define the active gradient area based on the thumb position.
    final Rect fActiveGradientRect = Rect.fromLTRB(
      fTrackRect.left,
      (textDirection == TextDirection.ltr)
          ? fTrackRect.top - (additionalActiveTrackHeight / 2)
          : fTrackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? fTrackRect.bottom + (additionalActiveTrackHeight / 2)
          : fTrackRect.bottom,
    );

    // Assign the track segment paints: leading is active, trailing is inactive.
    final ColorTween fActiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );

    final ColorTween fInactiveTrackColorTween = dDarkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor,
          )
        : fActiveTrackColorTween;

    final Paint fActivePaint = Paint()
      ..shader = kGradient.createShader(fActiveGradientRect)
      ..color = fActiveTrackColorTween.evaluate(enableAnimation)!;

    final Paint fInactivePaint = Paint()
      ..color = fInactiveTrackColorTween.evaluate(enableAnimation)!;

    final Paint fLeftTrackPaint;
    final Paint fRightTrackPaint;

    // Determine track paint based on text direction.
    switch (textDirection) {
      case TextDirection.ltr:
        fLeftTrackPaint = fActivePaint;
        fRightTrackPaint = fInactivePaint;
        break;
      case TextDirection.rtl:
        fLeftTrackPaint = fInactivePaint;
        fRightTrackPaint = fActivePaint;
        break;
    }

    // Define the corner radius for the tracks.
    final Radius fTrackRadius = Radius.circular(fTrackRect.height / 2);
    final Radius fActiveTrackRadius =
        Radius.circular(fTrackRect.height / 2 + 1);

    // Draw the active track segment.
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        fTrackRect.left,
        (textDirection == TextDirection.ltr)
            ? fTrackRect.top - (additionalActiveTrackHeight / 2)
            : fTrackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? fTrackRect.bottom + (additionalActiveTrackHeight / 2)
            : fTrackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? fActiveTrackRadius
            : fTrackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? fActiveTrackRadius
            : fTrackRadius,
      ),
      fLeftTrackPaint,
    );

    // Draw the inactive track segment.
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? fTrackRect.top - (additionalActiveTrackHeight / 2)
            : fTrackRect.top,
        fTrackRect.right,
        (textDirection == TextDirection.rtl)
            ? fTrackRect.bottom + (additionalActiveTrackHeight / 2)
            : fTrackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? fActiveTrackRadius
            : fTrackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? fActiveTrackRadius
            : fTrackRadius,
      ),
      fRightTrackPaint,
    );
  }
}
