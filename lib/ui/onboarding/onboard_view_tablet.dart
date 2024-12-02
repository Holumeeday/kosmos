import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/onboarding_model.dart';

/*
This class shows the onboarding view for tablet
@author: Ugochukwu Umeh
@date: 16 Feb, 2023
@modified: 16 Jun, 2023
*/
class OnboardTabletView extends StatelessWidget {
  final OnboardPageModel fPageModel;

  const OnboardTabletView({
    super.key,
    required this.fPageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Image
          Expanded(
            flex: 2,
            child: Semantics(
              label: semanticLabelFromImageType(fPageModel.imageType, context),
              container: true,
              sortKey: const OrdinalSortKey(0),
              child: Image.asset(
                fPageModel.image,
              ),
            ),
          ),

          //Title and subtitle
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Title
                TextScaleFactorClamp(
                  fChild: Text(
                    context.loc.setOnboardTitle(fPageModel.title),
                    textAlign: TextAlign.center,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: context.colors.secondary,
                    ),
                  ),
                ),
                const VSpace(5),

                //Subtitle
                Flexible(
                  child: TextScaleFactorClamp(
                    fChild: Text(
                      context.loc.setOnboardDetails(fPageModel.title),
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Semantic label text based on the image shown
  String semanticLabelFromImageType(
      OnboardingImageType imageType, BuildContext context) {
    return switch (imageType) {
      OnboardingImageType.meetOnboardImage =>
        context.loc.happyFriendsEnjoyingRecreationalActivities,
      OnboardingImageType.earnOnboardImage =>
        context.loc.imageOfCelebrationForFinancialGain,
      OnboardingImageType.createOnboardImage =>
        context.loc.personEngagingInRecreationalActivities,
      OnboardingImageType.stayConnectedOnboardImage =>
        context.loc.connectWithTheCommunity,
    };
  }
}
