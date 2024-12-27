
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key, 
    required this.fShowAll, required this.fText1, required this.fText2,
  });

  /// Show all
  final bool fShowAll;
  final String fText1;
  final String fText2;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.extralong4,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: !fShowAll
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fText1,
                  style: context.appTextTheme.buttonSmall,
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.appTextTheme.buttonSmall?.color,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fText2,
                  style: context.appTextTheme.buttonSmall,
                ),
                Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: context.appTextTheme.buttonSmall?.color,
                ),
              ],
            ),
    );
  }
}