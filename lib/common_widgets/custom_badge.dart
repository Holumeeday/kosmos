import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class shows an icon and a badge
@author: Ugochukwu Umeh
*/
class CustomBadge extends StatelessWidget {
  ///The icon data
  final String fIcon;

  ///The number for the badge
  final int fNumber;

  ///When the icon is pressed
  final VoidCallback fIconPressed;

  /// The semantics label
  final String? fSemanticsLabel;

  ///Uses stack widget to and places [fNumber] over [fIconData]
  const CustomBadge({
    super.key,
    required this.fIcon,
    required this.fNumber,
    required this.fIconPressed,
    this.fSemanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: fSemanticsLabel,
      excludeSemantics: true,
      button: true,
      onTap: fIconPressed,
      child: IconButton(
        onPressed: fIconPressed,
        icon: Badge(
          backgroundColor: const Color(0xFFE94057),
          isLabelVisible: fNumber > 0,
          largeSize: 16,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          label: Text(
            fNumber < 100 ? '$fNumber' : '+99',
            textScaler: const TextScaler.linear(1),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: context.colors.onPrimary,
            ),
          ),
          child: SvgPicture.asset(
            fIcon,
            colorFilter: ColorFilter.mode(
              context.appColors.textColor!,
              BlendMode.srcIn,
            ),
            height: 25,
            width: 25,
          ),
        ),
      ),
    );
  }
}
