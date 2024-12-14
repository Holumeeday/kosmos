import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class shows the subscription plan icon
@author: Ugochukwu Umeh
*/
class SubscriptionPlanIcon extends StatelessWidget {
  ///The subscription plan
  final String fSubscriptionPlan;

  ///To show the subscription plan and move to subscription screen. Defaults
  ///to true
  final bool fShowPlanInfo;

  ///The Size of the plan icon. Defaults to 20. Do not scale as its already
  ///scaled
  final double fPlanSize;

  ///Displays the subscription plan badge. [fPlanSize] sets the size of the icon
  ///and defaults to 20 if not set. [fPlanSize] does not need to be scaled.
  const SubscriptionPlanIcon({
    super.key,
    required this.fSubscriptionPlan,
    this.fPlanSize = 18,
    this.fShowPlanInfo = true,
  });

  @override
  Widget build(BuildContext context) {
    final String semanticsLabel =
        context.loc.setSubscriptionPlanDialogDetail(fSubscriptionPlan);
    switch (fSubscriptionPlan) {
      case 'bronze':
        return _SubscriptionPlanItem(
          fPlanSize: fPlanSize,
          fPlanIcon: Assets.svgs.icons.bronzeSubscriptionPlan.path,
          fPlanInfo: fShowPlanInfo
              ? () {
                  _showSubscriptionPlanDialog(context);
                }
              : null,
          fSemanticsLabel: semanticsLabel,
        );
      case 'silver':
        return _SubscriptionPlanItem(
          fPlanSize: fPlanSize,
          fPlanIcon: Assets.svgs.icons.silverSubscriptionPlan.path,
          fPlanInfo: fShowPlanInfo
              ? () {
                  _showSubscriptionPlanDialog(context);
                }
              : null,
          fSemanticsLabel: semanticsLabel,
        );
      case 'gold':
        return _SubscriptionPlanItem(
          fPlanSize: fPlanSize,
          fPlanIcon: Assets.svgs.icons.goldSubscriptionPlan.path,
          fPlanInfo: fShowPlanInfo
              ? () {
                  _showSubscriptionPlanDialog(context);
                }
              : null,
          fSemanticsLabel: semanticsLabel,
        );
      case 'diamond':
        return _SubscriptionPlanItem(
          fPlanSize: fPlanSize,
          fPlanIcon: Assets.svgs.icons.diamondSubscriptionPlan.path,
          fPlanInfo: fShowPlanInfo
              ? () {
                  _showSubscriptionPlanDialog(context);
                }
              : null,
          fSemanticsLabel: semanticsLabel,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  ///Shows the subscription plan dialog
  void _showSubscriptionPlanDialog(BuildContext context) {
    showCustomDialog(
      context,
      builder: (context) {
        final ColorScheme fColorScheme = context.colors;
        final TextTheme fTextTheme = context.textTheme;
        final AppColors fAppColors = context.appColors;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubscriptionPlanIcon(
                fSubscriptionPlan: fSubscriptionPlan,
                fPlanSize: 24,
              ),
              const HSpace(5),
              Flexible(
                child: Text(
                  context.loc.setFullNameSubscriptionPlan(
                    fSubscriptionPlan,
                  ),
                  textAlign: TextAlign.center,
                  style: fTextTheme.headlineLarge?.copyWith(
                    color:
                        fSubscriptionPlan.getSubscriptionPlanColor(fAppColors),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          content: Scrollbar(
            thickness: 5,
            child: SingleChildScrollView(
              child: Text(
                context.loc.setSubscriptionPlanDialogDetail(
                  fSubscriptionPlan,
                ),
                textAlign: TextAlign.center,
                style: fTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Closes the dialog
                context.pop();
                // Moves to the subscription screen
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.loc.seeMoreLink,
                    style: fTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: fColorScheme.secondary,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: fColorScheme.secondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/*
This class shows the icon
@author: Ugochukwu Umeh
*/
class _SubscriptionPlanItem extends StatelessWidget {
  ///The plan icon
  final String fPlanIcon;

  ///More information about the plan
  final VoidCallback? fPlanInfo;

  ///The height of the plan
  final double fPlanSize;

  /// The semantics label
  final String fSemanticsLabel;

  const _SubscriptionPlanItem({
    required this.fPlanIcon,
    required this.fPlanSize,
    required this.fSemanticsLabel,
    this.fPlanInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fPlanInfo,
      child: SvgPicture.asset(
        fPlanIcon,
        height: fPlanSize,
        width: fPlanSize,
        semanticsLabel: fSemanticsLabel,
      ),
    );
  }
}
