import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/onboarding/onboard_view.dart';
import 'package:playkosmos_v3/ui/select_language/widgets/select_language_list.dart';

/*
This class enables us change the language of the app
@author: Ugochukwu Umeh
*/
class SelectLanguageView extends StatelessWidget {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fShowBackButton: false,
        fElevation: 0,
        fCenterTitle: true,
        fSemanticLabel: context.loc.setAppLanguage,
        fTitle: Semantics(
          label: context.loc.playkosmosAppLogo,
          child: const PlaykosmosLogoText(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Choose language
              Text(
                context.loc.choosePreferredLanguage,
                textAlign: TextAlign.center,
                style: context.appTextTheme.caption?.copyWith(
                  fontSize: 14,
                ),
              ),
              const VSpace(32),

              //Select language
              const Flexible(
                child: SelectLanguageSearchList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 55,
        width: 55,
        child: PrimaryGradientButton(
          fShape: BoxShape.circle,
          fOnPressed: () {
            context.push(const OnboardView());
          },
          fChild: Semantics(
            label: context.loc.continueToNextScreen,
            child: Icon(
              Icons.arrow_forward,
              color: context.colors.onSecondary,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
