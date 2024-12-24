import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/buttons.dart';
import 'package:playkosmos_v3/common_widgets/sizes.dart';
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

extension ConnectionTypeUI on String {
  /// Returns a styled button widget based on the connection type string.
  /// If the string doesn't match any known type, returns "Unknown" text.
  Widget toConnectionButton(
    BuildContext context, {
    double? height,
    double? width,
    VoidCallback? onPressed,
  }) {
    // Try to match the string with enum
    ConnectionTypeEnum? type;
    try {
      type = ConnectionTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == toLowerCase(),
      );
    } catch (e) {
      return const Text('Unknown');
    }

    final buttonWidth = width ?? double.infinity;
    final buttonHeight = height ?? getRelativeScreenWidth(50, context);

    // Return button based on matched type
    switch (type) {
      case ConnectionTypeEnum.userFollowing:
        return PrimaryGradientButton(
          fHeight: buttonHeight,
          fWidth: buttonWidth,
          fOnPressed: onPressed ?? () {},
          fGradientColors: List.generate(3, (index) {
            return const Color(0xFFEDEDED);
          }),
          fChild: Text(
            context.loc.followingUser,
            style: context.textTheme.displayLarge!.copyWith(
              color: Colors.black,
              fontSize:getRelativeScreenWidth(14, context) ,
            ),
          ),
        );

      case ConnectionTypeEnum.followingUser:
        return PrimaryGradientButton(
          fHeight: buttonHeight,
          fWidth: buttonWidth,
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.followBack,
            style: context.textTheme.displayLarge!.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );

      case ConnectionTypeEnum.stranger:
        return PrimaryGradientButton(
          fHeight: buttonHeight,
          fWidth: buttonWidth,
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.followUser,
            style: context.textTheme.displayLarge!.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      case ConnectionTypeEnum.buddy:
        return PrimaryGradientButton(
          fHeight: buttonHeight,
          fWidth: buttonWidth,
          fGradientColors: List.generate(3, (index) {
            return const Color(0xFFD3D3D3);
          }),
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.buddies,
            style: context.textTheme.displayLarge!.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        );
    }
  }
}
