import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// A widget that displays a truncated text with an option to expand or collapse.
/// @author - Chidera Chijama
class ReadMoreText extends StatefulWidget {
  /// The full text to display.
  final String text;

  /// The maximum number of words to display before truncation.
  final int maxWords;

  const ReadMoreText({
    super.key,
    required this.text,
    this.maxWords = 30, // Default to 30 words.
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  /// Tracks whether the text is expanded or collapsed.
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // Split the text into a list of words.
    final words = widget.text.split(' ');

    // Determine if the text needs truncation.
    final needsReadMore = words.length > widget.maxWords;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display either the full text or a truncated version.
        Text(
          _expanded
              ? widget.text
              : words.take(widget.maxWords).join(' ') +
                  (needsReadMore ? '...' : ''), // Add ellipsis if truncated.
          style: context.appTextTheme.body,
        ),
        if (needsReadMore)
          // Add a button to toggle between "Read More" and "Show Less".
          TextButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded; // Toggle expanded state.
              });
            },
            child: Text(
              _expanded ? 'Show Less' : 'Read More', // Button label changes dynamically.
              style: context.textTheme.displayLarge!.copyWith(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
