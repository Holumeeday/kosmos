import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This holds the modal items
@author: Ugochukwu Umeh
*/
class MoreOptionsItem extends StatelessWidget {
  /// The text
  final String fText;

  /// The text color
  final Color? fTextColor;

  /// When the text is clicked
  final VoidCallback fOnTap;

  const MoreOptionsItem({
    super.key,
    required this.fText,
    required this.fOnTap,
    this.fTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: fOnTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            child: Text(
              fText,
              style: context.textTheme.bodyMedium?.copyWith(
                color: fTextColor,
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
