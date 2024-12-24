import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';

/// A widget that displays a carousel of images with smooth transitions and navigation controls.
/// Features:
/// - Swipe navigation between images.
/// - Tap-to-navigate (left/right).
/// - Animated transitions.
/// - Carousel indicators.
///
/// @param [images] A list of image URLs to be displayed in the carousel.
class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key, required this.images});
  final List<String> images;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController; // Controller to manage page navigation
  int fActivePage = 0; // Tracks the currently active page

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        final fImageLength = state.fBuddiesModel.profileImages.length;

        return Stack(
          children: [
            // Image carousel with swipe and tap-to-navigate functionality
            GestureDetector(
              onTapDown: (details) => _onTapDown(details, fImageLength),
              child: PageView.builder(
                controller: _pageController,
                itemCount: fImageLength,
                onPageChanged: (page) {
                  setState(() {
                    fActivePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          state.fBuddiesModel.profileImages[pagePosition],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Carousel indicator to show the current position
            Positioned(
              top: 20,
              child: CarouselIndicator(
                fImagesLength: fImageLength,
                fCurrentIndex: fActivePage,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handles tap gestures to navigate between pages.
  ///
  /// Taps on the left side navigate to the previous page, while taps on the right navigate to the next page.
  /// If the last page is reached, tapping on the right wraps back to the first page.
  ///
  /// @param [details] The tap details containing position information.
  /// @param [imageLength] The total number of images in the carousel.
  void _onTapDown(TapDownDetails details, int imageLength) {
    final double fScreenWidth = getScreenWidth(context);
    final double fDx = details.globalPosition.dx;

    if (fDx < fScreenWidth / 3) {
      // Left tap - go to the previous page
      if (fActivePage > 0) {
        _pageController.animateToPage(
          fActivePage - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (fDx > 2 * fScreenWidth / 3) {
      // Right tap - go to the next page
      if (fActivePage < imageLength - 1) {
        _pageController.animateToPage(
          fActivePage + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Wrap to the first page
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
