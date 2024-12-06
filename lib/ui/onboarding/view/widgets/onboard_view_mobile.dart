import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/onboarding_model.dart';

/*
This class shows the onboarding view for mobile
@author: Ugochukwu Umeh
@date: 16 Feb, 2023
@modified: 16 Jun, 2023
*/
class OnboardMobileView extends StatelessWidget {
  final OnboardPageModel fPageModel;

  const OnboardMobileView({
    super.key,
    required this.fPageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.85,
              child: Semantics(
                container: true,
                sortKey: const OrdinalSortKey(0),
                label:
                    semanticLabelFromImageType(fPageModel.imageType, context),
                child: Image.asset(
                  fPageModel.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          //Texts
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextScaleFactorClamp(
                fChild: Text(
                  context.loc.setOnboardTitle(fPageModel.title),
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.header1,
                ),
              ),
              const VSpace(8),

              //Subtitle
              TextScaleFactorClamp(
                fChild: Text(
                  context.loc.setOnboardDetails(fPageModel.title),
                  textAlign: TextAlign.center,
                  style: context.appTextTheme.body,
                ),
              ),
            ],
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
