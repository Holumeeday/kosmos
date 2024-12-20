import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key, required this.images});
  final List<String> images;
  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;
  int fActivePage = 0;

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

        return SizedBox(
          height: getScreenHeight(context) * 0.6,
          width: getScreenWidth(context),
          child: Stack(
            children: [
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
              Positioned(
                top: 20,
                child: Indicator(
                  fImagesLength: fImageLength,
                  fCurrentIndex: fActivePage,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTapDown(TapDownDetails details, int imageLength) {
    final double fScreenWidth = getScreenWidth(context);
    final double fDx = details.globalPosition.dx;

    if (fDx < fScreenWidth / 3) {
      // Left tap - go to previous page
      if (fActivePage > 0) {
        _pageController.animateToPage(
          fActivePage - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (fDx > 2 * fScreenWidth / 3) {
      // Right tap - go to next page
      if (fActivePage < imageLength - 1) {
        _pageController.animateToPage(
          fActivePage + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Wrap to first page
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.fImagesLength,
    required this.fCurrentIndex,
  });

  final int fImagesLength;
  final int fCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      width: getScreenWidth(context),
      height: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          fImagesLength,
          (index) {
            final bool active = index == fCurrentIndex;
            return Container(
              // margin: const EdgeInsets.symmetric(horizontal: 4),
              width: getScreenWidth(context) / (fImagesLength + .5),
              decoration: BoxDecoration(
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
                color: active
                    ? Colors.white
                    : const Color(0xFF000000).withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(4.89)),
              ),
            );
          },
        ),
      ),
    );
  }
}
