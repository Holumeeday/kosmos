import 'package:flutter/cupertino.dart';

/*
This class enables us create a vertical space between widgets
@author: Jahswill Esquire
@date: May, 2023
@modified: 16 Jun, 2023
@by: Ugochukwu Umeh
*/
class VSpace extends StatelessWidget {
  const VSpace(
    this.fHeight, {
    super.key,
  });
  final double fHeight;
  @override
  Widget build(BuildContext context) {
    return _SizedBoxWidget(
      fHeight: fHeight,
      fWidth: 0,
    );
  }
}

/*
This class enables us create a horizontal space between widgets
@author: Jahswill Esquire
@date: May, 2023
@modified: 16 Jun, 2023
@by: Ugochukwu Umeh
*/
class HSpace extends StatelessWidget {
  const HSpace(this.fWidth, {super.key});
  final double fWidth;
  @override
  Widget build(BuildContext context) {
    return _SizedBoxWidget(
      fHeight: 0,
      fWidth: fWidth,
    );
  }
}

/*
This class is to building block for horizontal and vertical spacing
@author: Jahswill Esquire
@date: May, 2023
@modified: 16 Jun, 2023
@by: Ugochukwu Umeh
*/
class _SizedBoxWidget extends StatelessWidget {
  const _SizedBoxWidget({required this.fHeight, required this.fWidth});
  final double fHeight, fWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fHeight,
      width: fWidth,
    );
  }
}


/* @author: Chijama Chidera */
/// A widget that provides relative horizontal spacing based on screen width.
/// This ensures the spacing scales proportionally across different devices.
class HRelativeSpace extends StatelessWidget {
  /// The proportionate width to calculate relative spacing.
  final double x;

  /// Creates a horizontal spacing widget based on relative screen width.
  const HRelativeSpace(this.x, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: getRelativeScreenWidth(x, context));
  }
}


/* @author: Chijama Chidera */

/// A widget that provides relative vertical spacing based on screen height.
/// This ensures the spacing scales proportionally across different devices.
class YRelativeSpace extends StatelessWidget {
  /// The proportionate height to calculate relative spacing.
  final double y;

  /// Creates a vertical spacing widget based on relative screen height.
  const YRelativeSpace(this.y, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: getRelativeScreenHeight(y, context));
  }
}


/* @author: Chijama Chidera */

/// Retrieves the total screen height using [MediaQuery].
/// This helps in calculating relative height for a responsive UI.
double getScreenHeight(BuildContext context) {
  double screenHeight = MediaQuery.sizeOf(context).height;
  debugPrint("##### Screen Height: $screenHeight");
  return screenHeight;
}

/// Retrieves the total screen width using [MediaQuery].
/// This helps in calculating relative width for a responsive UI.
double getScreenWidth(BuildContext context) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  debugPrint("##### Screen Width: $screenWidth");
  return screenWidth;
}

/// Calculates a proportionate height relative to the current screen size.
/// 
/// [inputHeight]: The height value based on the design (e.g., Figma).
/// [context]: The BuildContext used to retrieve the screen height.
/// 
/// The calculation is based on a **base height of 958px**, which is the height
/// used in the original UI design. The value scales up or down proportionally
/// to match the device screen size.
double getRelativeScreenHeight(double inputHeight, BuildContext context) {
  final screenHeight = getScreenHeight(context);
  return (inputHeight / 958) * screenHeight;
}

/// Calculates a proportionate width relative to the current screen size.
/// 
/// [inputWidth]: The width value based on the design (e.g., Figma).
/// [context]: The BuildContext used to retrieve the screen width.
/// 
/// The calculation is based on a **base width of 440px**, which is the width
/// used in the original UI design. The value scales up or down proportionally
/// to match the device screen size.
double getRelativeScreenWidth(double inputWidth, BuildContext context) {
  final screenWidth = getScreenWidth(context);
  return (inputWidth / 440) * screenWidth;
}
