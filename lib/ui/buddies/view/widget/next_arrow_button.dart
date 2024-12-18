import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/theme/app_colors.dart';

class NextArrowButton extends StatelessWidget {
  const NextArrowButton({
    this.fOnTap,
    super.key,
  });
  final void Function()? fOnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fOnTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
            gradient: RadialGradient(center: Alignment.topCenter, stops: const [
              .5,
              .8,
              1
            ], colors: [
              const Color(0xFF8A2387).withOpacity(0.2),
              const Color(0xFFE94057).withOpacity(0.2),
              AppColor.fPrimaryColor.withOpacity(0.2),
            ]),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              width: 2,
              color: context.colors.primary,
            )),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => const RadialGradient(
                  center: Alignment.topCenter,
                  stops: [.5, .8, 1],
                  colors: AppColor.fPrimaryGradient)
              .createShader(bounds),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 17,
          ),
        ),
      ),
    );
  }
}
