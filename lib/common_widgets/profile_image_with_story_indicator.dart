import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/// A circular profile image widget with a gradient indicator for stories.
///
/// This widget wraps the profile image inside a gradient circle to signify 
/// the presence of a story, commonly used in social media applications.
///
/// @author: [Your Name]
class ProfileImageWithStoryIndicator extends StatelessWidget {
  /// The URL of the profile image to display.
  ///
  /// If null, a default image URL is used.
  final String? fImage;

  const ProfileImageWithStoryIndicator({
    super.key,
    this.fImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Outer container for the gradient circle
      padding: const EdgeInsets.all(2), // Padding for the gradient border
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.5, 0.8, 1], // Gradient stops
          colors: AppColor.fPrimaryGradient, // Gradient colors
        ),
        shape: BoxShape.circle, // Circle shape for the gradient border
      ),
      child: CircleAvatar(
        backgroundColor: context.colors.surface, // Background for the main circle
        radius: getRelativeScreenHeight(39, context), // Outer circle radius
        child: CircleAvatar(
          radius: getRelativeScreenHeight(37, context), // Inner circle radius
          backgroundImage: NetworkImage(
            fImage ??
                "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg", // Default image
          ),
        ),
      ),
    );
  }
}