import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/onboarding_model.dart';
import 'package:playkosmos_v3/ui/auth_provider/auth_provider_view.dart';
import 'package:playkosmos_v3/ui/onboarding/onboard_view_mobile.dart';
import 'package:playkosmos_v3/ui/onboarding/onboard_view_tablet.dart';

/*
This class shows the onboarding view
@author: Ugochukwu Umeh
*/
class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  ///The current page for the page view
  int _dCurrentPage = 0;

  ///The page view list
  late List<OnboardPageModel> _dOnboardPageList;

  ///The page controller
  late PageController _fPageController;

  @override
  void initState() {
    super.initState();
    _fPageController = PageController(
      initialPage: _dCurrentPage,
    );
    _dOnboardPageList = [
      OnboardPageModel(
        title: 'meet',
        image: Assets.pngs.onboarding.meetOnboarding.path,
        imageType: OnboardingImageType.meetOnboardImage,
        percentValue: 0.25,
      ),
      OnboardPageModel(
        title: 'create',
        image: Assets.pngs.onboarding.createOnboarding.path,
        imageType: OnboardingImageType.createOnboardImage,
        percentValue: 0.5,
      ),
      OnboardPageModel(
        title: 'earn',
        image: Assets.pngs.onboarding.earnOnboarding.path,
        imageType: OnboardingImageType.earnOnboardImage,
        percentValue: 0.75,
      ),
      OnboardPageModel(
        title: 'stayConnected',
        image: Assets.pngs.onboarding.stayConnectedOnboarding.path,
        imageType: OnboardingImageType.stayConnectedOnboardImage,
        percentValue: 1,
      ),
    ];
  }

  @override
  void dispose() {
    _fPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        // Iƒ the pop wasn't done with the device back button do nothing
        if (didPop) return;
        goBack();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          fSemanticLabel: context.loc.playkosmosOnboardingScreen,
          fElevation: 0,
          fTitle: const PlaykosmosLogoText(),
          fAppBarHeight: context.scaleWithTextFactor(4, 50),
          fActions: [
            Visibility(
              visible: _dCurrentPage < _dOnboardPageList.length - 1,
              child: TextPrimaryButton(
                fOnTap: skipPages,
                fMargin: const EdgeInsets.symmetric(horizontal: 10),
                fChild: Text(
                  context.loc.skipText,
                  semanticsLabel: context.loc.skipToTheLastOnboardingPage,
                  style: context.appTextTheme.buttonMedium?.copyWith(
                    color: context.colors.tertiary,
                  ),
                ),
              ),
            ),
          ],
          fOnBackButtonPressed: goBack,
          fCenterTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Image and texts
              Expanded(
                child: PageView.builder(
                  controller: _fPageController,
                  onPageChanged: (int index) {
                    if (mounted) {
                      setState(() {
                        _dCurrentPage = index;
                      });
                    }
                  },
                  itemCount: _dOnboardPageList.length,
                  itemBuilder: (context, index) {
                    final OnboardPageModel fPageModel =
                        _dOnboardPageList[_dCurrentPage];
                    return DeviceScreensWidget(
                      fMobileScreen: OnboardMobileView(
                        fPageModel: fPageModel,
                      ),
                      fTabletScreen: OnboardTabletView(
                        fPageModel: fPageModel,
                      ),
                    );
                  },
                ),
              ),

              // Displays the circular indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _dOnboardPageList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    margin: const EdgeInsets.fromLTRB(8, 7, 8, 20),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _dCurrentPage == index
                          ? context.colors.primary
                          : context.colors.tertiary,
                    ),
                    // ),
                  ),
                ),
              ),

              //The next icon
              _dOnboardPageList[_dCurrentPage].percentValue == 1.0
                  ? Semantics(
                      label: context.loc.completeOnboarding,
                      button: true,
                      container: true,
                      sortKey: const OrdinalSortKey(1),
                      child: PrimaryGradientButton(
                        fWidth: 56,
                        fShape: BoxShape.circle,
                        fOnPressed: () {
                          // Save onboard status completed to true
                          context.push(const AuthProviderView(
                            fIsSignUp: true,
                          ));
                        },
                        fChild: Icon(
                          Icons.arrow_forward_rounded,
                          size: 30,
                          color: context.colors.onPrimary,
                        ),
                      ),
                    )
                  : Semantics(
                      button: true,
                      container: true,
                      label: context.loc.goToTheNextOnboardingPage,
                      sortKey: const OrdinalSortKey(1),
                      child: GestureDetector(
                        onTap: () {
                          _fPageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color:
                                    context.colors.secondary.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: ExcludeSemantics(
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  value: _dOnboardPageList[_dCurrentPage]
                                      .percentValue,
                                  color: context.colors.secondary,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 30,
                              color: context.colors.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),

              const VSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  /// Controls the back arrow
  void goBack() {
    if (_dCurrentPage == 0) {
      // Check if this page can be popped
      final canPop = Navigator.of(context).canPop();
      if (canPop) {
        Navigator.pop(context);
      }
    } else {
      _fPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  ///Controls the back arrow
  void skipPages() {
    _fPageController.animateToPage(
      _dOnboardPageList.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
