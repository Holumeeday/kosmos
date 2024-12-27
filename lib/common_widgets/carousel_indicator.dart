import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';

/// A widget that displays a horizontal row of indicators for a carousel.
/// 
/// Each indicator represents a page in the carousel, with the active page highlighted.
/// 
/// Parameters:
/// - [fImagesLength]: Total number of images/pages in the carousel.
/// - [fCurrentIndex]: The index of the currently active page.
/// @author- Chidera Chijama
class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    super.key,
    required this.fImagesLength,
    required this.fCurrentIndex,
  });

  /// The total number of images/pages in the carousel.
  final int fImagesLength;

  /// The index of the currently active page.
  final int fCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Full width of the screen
      width: getScreenWidth(context),
      height: 5, // Fixed height for the indicator row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          fImagesLength,
          (index) {
            final bool active = index == fCurrentIndex; // Check if the current index is active
            return Container(
              width: getScreenWidth(context) / (fImagesLength + 0.5),
              decoration: BoxDecoration(
                // Add shadow only for the active indicator
                boxShadow: active
                    ? const [
                        BoxShadow(
                          color: Color(0xFF2A2A2A),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : null,
                // Set color based on active state
                color: active
                    ? Colors.white
                    : const Color(0xFF000000).withOpacity(0.3),
                // Rounded corners for each indicator
                borderRadius: const BorderRadius.all(Radius.circular(4.89)),
              ),
            );
          },
        ),
      ),
    );
  }
}
