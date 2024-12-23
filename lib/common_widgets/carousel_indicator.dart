import 'package:flutter/material.dart';

import 'package:playkosmos_v3/common_widgets/common_widgets.dart';

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
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
