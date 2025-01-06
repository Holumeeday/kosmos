import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/common_widgets/subscription_plan_icon.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';

/*
This displays the user name and subscription plan
@author: Ugochukwu Umeh
*/
class UserNameAndPlan extends StatelessWidget {
  ///The user name
  final String fUserName;

  ///The plan
  final String? fSubscriptionPlan;

  ///The max lines
  final int? fMaxLines;

  ///The text size
  final double? fTextSize;

  ///The font size
  final FontWeight? fFontWeight;

  ///To move to profile
  final VoidCallback? fOnTap;

  ///The main alignment of the row
  final MainAxisAlignment fMainAlignment;

  ///The color of the name text
  final Color? fNameTextColor;

  ///The widget that's after the subscription plan and holds a bit of info
  final Widget? fOthers;

  ///The flex for the name text
  final int fNameFlex;

  ///The flex for the others widget
  final int fOthersFlex;

  const UserNameAndPlan({
    super.key,
    required this.fUserName,
    this.fSubscriptionPlan,
    required this.fTextSize,
    this.fFontWeight, 
    this.fOnTap,
    this.fMaxLines,
    this.fMainAlignment = MainAxisAlignment.start,
    this.fNameTextColor,
    this.fOthers,
    this.fNameFlex = 8,
    this.fOthersFlex = 8,
  });

  @override
  Widget build(BuildContext context) {
    final Widget fTextWidget = GestureDetector(
      onTap: fOnTap,
      child: Text(
        fUserName,
        overflow: TextOverflow.ellipsis,
        maxLines: fMaxLines,
        style: context.appTextTheme.header3!.copyWith(
          fontSize: fTextSize ?? 16,
          fontWeight: fFontWeight ?? FontWeight.w700,
          color: fNameTextColor ?? context.appColors.textColor,
        ),
      ),
    );
    return Row(
      mainAxisAlignment: fMainAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        // User name
        Flexible(
          flex: fNameFlex,
          child: fTextWidget,
        ),
        const HSpace(4),

        // Sub plan
        if (fSubscriptionPlan != null)
          Flexible(
            child: SubscriptionPlanIcon(
              fSubscriptionPlan: fSubscriptionPlan!,
            ),
          ),

        if (fOthers != null)
          Flexible(
            flex: fOthersFlex,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: fOthers,
            ),
          ),
      ],
    );
  }
}
