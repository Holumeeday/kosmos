import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// A custom container widget used to display summary information.
/// 
/// @author: CHidera Chijama
class InfoSummaryContainer extends StatelessWidget {
  /// The child widget to display inside the container.
  final Widget fChild;

  /// The padding inside the container. Defaults to `EdgeInsets.all(20)`.
  final EdgeInsetsGeometry? fPadding;

  /// The background color of the container. Defaults to the `reviewColor` 
  /// from the app's theme.
  final Color? fContainerColor;

  /// Creates an instance of `InfoSummaryContainer`.
  ///
  /// [fChild] is required and represents the content inside the container.
  /// [fPadding] allows custom padding. [fContainerColor] lets you set a custom 
  /// background color.
  const InfoSummaryContainer({
    super.key,
    required this.fChild,
    this.fPadding,
    this.fContainerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply padding and margin to the container
      padding: fPadding ?? const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Set the background color, defaulting to reviewColor
        color: fContainerColor ?? context.appColors.reviewColor,
        // Add a subtle shadow for a raised appearance
        boxShadow: [
          BoxShadow(
            color: context.colors.onSurface.withOpacity(0.06),
            offset: const Offset(0, 6), 
            blurRadius: 10, 
          ),
        ],
        // Round the edges of the container
        borderRadius: BorderRadius.circular(4),
        // Add a border with a slight opacity
        border: Border.all(
          color: context.appColors.onReviewColor!.withOpacity(0.1),
        ),
      ),
      // Place the child widget inside the container
      child: fChild,
    );
  }
}
