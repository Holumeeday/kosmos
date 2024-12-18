import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController? _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
    super.initState();
  }

  int fActivePage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyProfileCubit, BuddyProfileState>(
      builder: (context, state) {
        final fImageLength = state.fBuddiesModel.profileImages!.length;

        return SizedBox(
          height: getScreenHeight(context) * 0.6,
          width: getScreenWidth(context),
          child: Stack(
            children: [
              PageView.builder(
                  controller: _pageController,
                  itemCount: fImageLength,
                  onPageChanged: (page) {
                    int currentPage = page % fImageLength;
                    setState(() {
                      fActivePage = currentPage;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    int index = pagePosition % fImageLength;
                    bool active = index == fActivePage;
                    return slider(state.fBuddiesModel.profileImages!,
                        pagePosition, active);
                  }),
              Positioned(
                  top: 20,
                  child: Indicator(
                    fImagesLength: fImageLength,
                    fCurrentIndex: fActivePage,
                  )),
            ],
          ),
        );
      },
    );
  }
}

AnimatedContainer slider(List<String> image, int pagePosition, bool active) {
  return AnimatedContainer(
    duration: const Duration(microseconds: 500),
    // margin: EdgeInsets.only(right: 5),
    curve: Curves.easeInOut,
    decoration: const BoxDecoration(
      color: Colors.black,
      // image: DecorationImage(
      //   fit: BoxFit.cover,
      // image: NetworkImage(image[pagePosition]),
      // )
    ),
  );
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(fImagesLength, (index) {
          final bool active = index == fCurrentIndex;
          return Container(
            height: 5,
            width: getScreenWidth(context) / fImagesLength + 2,
            decoration: BoxDecoration(
                boxShadow: active
                    ? const [
                        BoxShadow(
                          color: Color(0xFF2A2A2A), // Drop shadow color
                          blurRadius: 10, // Shadow blur
                          spreadRadius: 0, // Spread
                          offset: Offset(0, 4), // X: 0, Y: 4
                        ),
                      ]
                    : null,
                color: active
                    ? Colors.white
                    : const Color(0xFF000000).withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(4.89))),
          );
        }),
      ),
    );
  }
}
