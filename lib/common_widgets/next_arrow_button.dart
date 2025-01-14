import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

/// A customizable button widget with a forward arrow icon.
///
/// This widget is typically used to navigate to the buddies profile page.
/// The button has a radial gradient background and a border for enhanced UI.
/// It allows the caller to define an action on tap.
///
/// @author: Chidera Chijama
class NextArrowButton extends StatelessWidget {
  /// Callback function triggered when the button is tapped.
  final void Function()? fOnTap;

  /// Constructor for NextArrowButton.
  const NextArrowButton({
    this.fOnTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Trigger the specified callback when the button is tapped.
      onTap: fOnTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

        // Button decoration with a radial gradient, border, and rounded corners.
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            stops: const [
              0.5,
              0.8,
              1,
            ],
            colors: [
              const Color(0xFF8A2387).withOpacity(0.2), // Purple with transparency
              const Color(0xFFE94057).withOpacity(0.2), // Pink with transparency
              AppColor.fPrimaryColor.withOpacity(0.2), // Primary color with transparency
            ],
          ),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            width: 2,
            color: context.colors.primary,
          ),
        ),

        // Button icon with gradient coloring.
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => const LinearGradient(
            stops: [0.3, 0.7, 1],
            colors: AppColor.fPrimaryGradient,
          ).createShader(bounds),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 17,
          ),
        ),
      ),
    );
  }
}
