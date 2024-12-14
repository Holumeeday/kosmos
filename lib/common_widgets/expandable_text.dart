import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This makes a text expandable or collapsed
@author: Ugochukwu Umeh
*/
class ExpandableText extends StatefulWidget {
  ///The text to be expandable
  final String fText;

  ///The number of min lines
  final int fTrimLines;

  /// The color of the see more or see less text
  final Color? fExpandableTextColor;

  /// The distance from the previous element to the text. Defaults to 16
  final double fDistanceFromPrevious;

  const ExpandableText({
    super.key,
    required this.fText,
    required this.fTrimLines,
    this.fExpandableTextColor,
    this.fDistanceFromPrevious = 16,
  });

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _dSeeMore = true;

  void _onTapLink() {
    if (mounted) {
      setState(
        () => _dSeeMore = !_dSeeMore,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors fAppColors = context.appColors;
    final TextScaler fTextScaler = MediaQuery.textScalerOf(context);

    ///The default text style used
    final TextStyle fDefaultTextStyle = TextStyle(
      fontSize: 14,
      color: fAppColors.textColor,
      height: 1.5,
    );

    /// Text direction
    final TextDirection fTextDirection = Directionality.of(context);

    /// The see more link
    final TextSpan fLink = TextSpan(
      text: _dSeeMore ? '${context.loc.seeMore}...' : context.loc.seeLess,
      style: fDefaultTextStyle.copyWith(
        fontWeight: FontWeight.w700,
        color: widget.fExpandableTextColor,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
      semanticsLabel: _dSeeMore ? context.loc.seeMore : context.loc.seeLess,
    );

    //The resulting widget
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final TextSpan text = TextSpan(
          text: widget.fText,
          style: fDefaultTextStyle.copyWith(
            fontWeight: FontWeight.w400,
          ),
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: fLink,
          textScaler: fTextScaler,
          maxLines: widget.fTrimLines,
          textDirection: fTextDirection,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: maxWidth,
        );
        final Size linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(
          minWidth: 0,
          maxWidth: maxWidth,
        );
        final textSize = textPainter.size;

        // Get the endIndex of data
        int endIndex;
        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width;
          final pos = textPainter.getPositionForOffset(
            Offset(
              fTextDirection == TextDirection.rtl
                  ? readMoreSize
                  : textSize.width - readMoreSize,
              textSize.height,
            ),
          );
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          TextPosition pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
        }
        TextSpan textSpan;

        if (textPainter.didExceedMaxLines) {
          final String text =
              _dSeeMore ? widget.fText.substring(0, endIndex) : widget.fText;
          textSpan = TextSpan(
            text: text,
            style: fDefaultTextStyle.copyWith(fontWeight: FontWeight.w400),
            children: <TextSpan>[fLink],
          );
        } else {
          textSpan = TextSpan(
            text: widget.fText,
            style: fDefaultTextStyle.copyWith(
              fontWeight: FontWeight.w400,
            ),
          );
        }

        return RichText(
          text: textSpan,
          softWrap: true,
          textScaler: fTextScaler,
        );
      },
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.fDistanceFromPrevious),
      child: result,
    );
  }
}
