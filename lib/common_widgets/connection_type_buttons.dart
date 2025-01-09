import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/// Connection button widget
class ConnectionButton extends StatelessWidget {
  final bool follower;
  final bool following;
  final VoidCallback? onPressed;

  const ConnectionButton({
    super.key,
    required this.follower,
    required this.following,
    this.onPressed,
  });

  /// Determines the connection type based on `follower` and `following`
  ConnectionTypeEnum _getConnectionType() {
    if (follower && following) {
      return ConnectionTypeEnum.buddy;
    } else if (follower && !following) {
      return ConnectionTypeEnum.followingUser;
    } else if (!follower && following) {
      return ConnectionTypeEnum.userFollowing;
    } else {
      return ConnectionTypeEnum.stranger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _getConnectionType();
    // Return button based on matched type
    switch (type) {
      case ConnectionTypeEnum.userFollowing:
        return PrimaryGradientButton(
          fPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9.5),
          // fWidth: getRelativeScreenWidth(90, context),
          // fHeight: getRelativeScreenHeight(40, context),
          fOnPressed: onPressed ?? () {},
          fGradientColors: List.generate(3, (index) {
            return const Color(0xFFEDEDED);
          }),
          fChild: Text(
            context.loc.followingUser,
            style: context.appTextTheme.header3?.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        );

      case ConnectionTypeEnum.followingUser:
        return PrimaryGradientButton(
          fPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9.5),
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.followBack,
            style: context.appTextTheme.header3
                ?.copyWith(color: Colors.white, fontSize: 16),
          ),
        );

      case ConnectionTypeEnum.stranger:
        return PrimaryGradientButton(
          fPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9.5),
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.followUser,
            style: context.appTextTheme.header3
                ?.copyWith(color: Colors.white, fontSize: 16),
          ),
        );
      case ConnectionTypeEnum.buddy:
        return PrimaryGradientButton(
          fPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9.5),
          fGradientColors: List.generate(3, (index) {
            return const Color(0xFFD3D3D3);
          }),
          fOnPressed: onPressed ?? () {},
          fChild: Text(
            context.loc.buddies,
            style: context.appTextTheme.header3
                ?.copyWith(color: Colors.black, fontSize: 16),
          ),
        );
    }
  }
}


