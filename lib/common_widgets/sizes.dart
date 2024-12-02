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
