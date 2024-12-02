import 'package:flutter/material.dart';

/*
This is used to style a word in a localized text
@author: Ugochukwu Umeh
*/
class StylingLocalizations extends StatelessWidget {
  ///The localized text
  final String fLocalizedText;

  ///The texts to style
  final List<String> fTextToStyle;

  ///The general style
  final TextStyle? fGeneralStyle;

  ///The style to text
  final TextStyle? fStyleText;

  /// The text align
  final TextAlign? fTextAlign;

  /// Text overflow strategy
  final TextOverflow? fOverflow;

  /// Text max line
  final int? fMaxLine;

  const StylingLocalizations({
    super.key,
    required this.fLocalizedText,
    required this.fTextToStyle,
    this.fGeneralStyle,
    this.fStyleText,
    this.fTextAlign,
    this.fOverflow,
    this.fMaxLine,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> children = [];

    int currentIndex = 0;

    // Iterate through the localized text
    while (currentIndex < fLocalizedText.length) {
      // Find the next occurrence of any text to style
      int nextOccurrence = fLocalizedText.length;
      String nextText = '';

      for (final textToStyle in fTextToStyle) {
        int occurrence = fLocalizedText.indexOf(textToStyle, currentIndex);
        if (occurrence != -1 && occurrence < nextOccurrence) {
          nextOccurrence = occurrence;
          nextText = textToStyle;
        }
      }

      // Add the non-styled text before the next occurrence
      children.add(
        TextSpan(
          text: fLocalizedText.substring(currentIndex, nextOccurrence),
          style: fGeneralStyle,
        ),
      );

      // Add the styled text if an occurrence was found
      if (nextOccurrence < fLocalizedText.length) {
        children.add(
          TextSpan(
            text: nextText,
            style: fStyleText,
          ),
        );

        // Move the current index to the end of the styled text
        currentIndex = nextOccurrence + nextText.length;
      } else {
        // No more occurrences found, break the loop
        break;
      }
    }

    return Text.rich(
      TextSpan(
        children: children,
      ),
      textAlign: fTextAlign,
      maxLines: fMaxLine,
      overflow: fOverflow,
    );
  }
}
