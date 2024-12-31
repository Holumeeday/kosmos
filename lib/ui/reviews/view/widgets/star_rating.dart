import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// A widget that displays a star rating system.
/// 
/// The number of stars, current rating, and the ability to change the rating 
/// can be customized through the widget's properties.
class StarRating extends StatelessWidget {
  /// The total number of stars in the rating system.
  final int starCount;

  /// The current rating value (can include fractional values for half-stars).
  final double rating;

  /// A callback triggered when a star is tapped, providing the new rating value.
  final void Function(double)? onRatingChanged;

  /// Constructs a `StarRating` widget with customizable properties.
  const StarRating({
    super.key,
    this.starCount = 5, // Defaults to 5 stars.
    this.rating = .0,   // Defaults to no rating.
    this.onRatingChanged,
  });

  /// Builds an individual star widget based on its index and the current rating.
  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    // Determine the star's appearance based on the current rating.
    if (index >= rating) {
      // Empty star if the index is greater than or equal to the rating.
      icon = Icon(
        Icons.star,
        color: context.appColors.darkGreyColor, // Grey for unselected stars.
      );
    } else if (index > rating - 1 && index < rating) {
      // Half star if the index is within a fractional range.
      icon = const Icon(
        Icons.star_half,
        color: Colors.amber, // Amber color for selected stars.
      );
    } else {
      // Full star for indices less than the rating.
      icon = const Icon(
        Icons.star,
        color: Colors.amber, // Amber color for selected stars.
      );
    }

    // Wrap the star in an InkResponse for tap interaction.
    return InkResponse(
      onTap: () => onRatingChanged?.call(index + 1.0), // Update rating on tap.
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate a row of stars based on the total count.
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
