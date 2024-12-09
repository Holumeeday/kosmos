import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays when a list is empty
@author: Ugochukwu Umeh
*/
class EmptyState extends StatelessWidget {
  /// A button if any. Add space as desired
  final Widget? fButton;

  /// An icon button if any
  final Widget? fIconWidget;

  ///The icon to be displayed. An svg file
  final String? fEmptyIcon;

  /// The title text
  final String fTitleText;

  /// Other details about the empty state
  final String? fSubtitleText;

  /// The subtitle widget if any
  final Widget? fSubtitleWidget;

  /// The scroll physics
  final ScrollPhysics? fScrollPhysics;

  const EmptyState({
    super.key,
    this.fEmptyIcon,
    required this.fTitleText,
    this.fSubtitleText,
    this.fButton,
    this.fIconWidget,
    this.fSubtitleWidget,
    this.fScrollPhysics,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: fScrollPhysics,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Empty icon
            if (fEmptyIcon != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: SvgPicture.asset(
                  fEmptyIcon!,
                ),
              ),

            // An icon widget
            if (fIconWidget != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: fIconWidget!,
              ),

            // Text title
            Text(
              fTitleText,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colors.secondary,
              ),
            ),
            const VSpace(10),

            // Text subtitle
            fSubtitleWidget ??
                ((fSubtitleText != null)
                    ? Text(
                        fSubtitleText!,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colors.tertiary,
                        ),
                      )
                    : const SizedBox.shrink()),

            // Button
            if (fButton != null) fButton!,
          ],
        ),
      ),
    );
  }
}
