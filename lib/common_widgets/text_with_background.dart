import 'package:flutter/material.dart';

/*
This class shows a text with a colored background
@author: Ugochukwu Umeh
*/
class TextWithBackground extends StatelessWidget {
  ///The color of the text. This is also used to generate the color of the
  ///container when [fContainerColor] is empty
  final Color? fBackgroundColor;

  ///The color of the container
  final Color? fContainerColor;

  ///The text
  final String fText;

  ///If the text should be centered. Defaults to false
  final bool? fIsCentered;

  ///The font size.
  final double fTextSize;

  ///The font weight. Defaults to regular
  final FontWeight? fFontWeight;

  ///The padding
  final EdgeInsets? fPadding;

  ///The margin
  final EdgeInsets? fMargin;

  ///A border radius if any.
  final double? fBorderRadius;

  ///Max lines
  final int? fMaxLines;

  ///If there's an overflow
  final TextOverflow? fTextOverflow;

  ///The border of the container
  final BoxBorder? fContainerBorder;

  ///For setting the border radius property itself rather than just the radius
  ///value
  final BorderRadiusGeometry? fBorderGeometry;

  /// The width of the container
  final double? fWidth;

  /// The semantics label
  final String? fSemanticLabel;

  ///Uses a default font weight of 400 and a size of 22. [fBackgroundColor] is
  ///the color of the text and is also used to generate the color of the
  ///container when [fContainerColor] is empty
  const TextWithBackground({
    super.key,
    required this.fText,
    required this.fBackgroundColor,
    this.fTextSize = 22,
    this.fFontWeight,
    this.fIsCentered = false,
    this.fPadding,
    this.fMargin,
    this.fBorderRadius,
    this.fMaxLines,
    this.fTextOverflow,
    this.fContainerColor,
    this.fContainerBorder,
    this.fBorderGeometry,
    this.fWidth,
    this.fSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: fSemanticLabel ?? fText,
      excludeSemantics: true,
      child: Container(
        margin: fMargin,
        width: fWidth,
        decoration: BoxDecoration(
          color: fContainerColor ?? fBackgroundColor?.withOpacity(0.1),
          borderRadius: (fBorderGeometry != null)
              ? fBorderGeometry
              : (fBorderRadius != null)
                  ? BorderRadius.circular(fBorderRadius!)
                  : BorderRadius.zero,
          border: fContainerBorder,
        ),
        padding: fPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 9,
            ),
        child: Text(
          fText,
          maxLines: fMaxLines,
          overflow: fTextOverflow,
          style: TextStyle(
            fontSize: fTextSize,
            fontWeight: fFontWeight,
            color: fBackgroundColor,
          ),
          textAlign: fIsCentered == false ? null : TextAlign.center,
        ),
      ),
    );
  }
}
