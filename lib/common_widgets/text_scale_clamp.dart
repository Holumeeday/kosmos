import 'package:flutter/material.dart';

/*
This class clamps the text scale factor between the min and 1.5
@author: Ugochukwu Umeh
*/
class TextScaleFactorClamp extends StatelessWidget {
  ///This helps to clamp the text scale between the min and 1.5
  const TextScaleFactorClamp({
    super.key,
    required this.fChild,
  });

  final Widget fChild;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: fChild,
    );
  }
}
