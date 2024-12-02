import 'package:flutter/material.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This class enables us build responsive widget for mobile and tablets
@author: Ugochukwu Umeh
*/
class DeviceScreensWidget extends StatelessWidget {
  ///The mobile widget
  final Widget fMobileScreen;

  ///The tablet widget
  final Widget fTabletScreen;

  const DeviceScreensWidget({
    super.key,
    required this.fMobileScreen,
    required this.fTabletScreen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return fTabletScreen;
        }
        return fMobileScreen;
      },
    );
  }
}

/*
This class enables us build responsive widget for mobile and tablets using one
child
@author: Ugochukwu Umeh
*/
class DeviceScreenWidget extends StatelessWidget {
  /// if its parent is a sliver widget
  final bool fIsParentSliver;

  /// The responsive child
  final Widget Function(BuildContext, DeviceScreenTypeEnum) fChild;

  const DeviceScreenWidget({
    super.key,
    required this.fChild,
    this.fIsParentSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    if (fIsParentSliver) {
      return SliverLayoutBuilder(
        builder: (context, constraints) {
          return fChild(
            context,
            constraints.crossAxisExtent.deviceScreenType,
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return fChild(
          context,
          constraints.maxWidth.deviceScreenType,
        );
      },
    );
  }
}
