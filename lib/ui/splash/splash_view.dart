import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/select_language/select_language_view.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class displays all the splash screen animation for the Playkosmos application
before navigating to the language screen
@author Adeyemi Adeseye
*/

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ///This is a list of the playkosmos center logo white and blue
  late final List<String> _fOnboardImages;

  ///This variables tracks how many times the opacity is swapped (max=2)
  int _dOpacitySwapCount = 0;

  ///swaps the container opacity to give a fade in, fade out effect
  bool _dOpacityVisible = true;

  /// tracks if the playkosmos text is visible on the screen or not
  bool _dTextVisible = false;

  /// index to display each of the 2 initial white and blue logo
  int _dLogoIndex = 0;

  /// periodic timer to change the animation state
  late final Timer _fSplashLogoTimer;

  ///playkosmos text initial offset value before animation
  ///starts, it will set the text to offscreen using media query
  late Offset _dTextOffset = const Offset(5, 0);

  ///playkosmos blue logo offset value before animation
  Offset _dBlueLogoOffset = const Offset(0, 0);

  ///toggle between showing static playkosmos blue logo or the
  /// animated slide of the same logo that will be moved to the left
  int _dMovableLogo = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation(); // start the animation display
    _fOnboardImages = [
      Assets.svgs.branding.logoWhiteBg.path,
      Assets.svgs.branding.logoColoredBg.path,
    ];
  }

  @override
  void dispose() {
    _fSplashLogoTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, //prevent clipping to enhance performance
        children: [
          AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: _dOpacityVisible ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            // The blue background
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: kScaffoldBgGradientStops,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColor.fPrimaryGradient,
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          //swaps between the static blue and animated slide logo
          IndexedStack(
            index: _dMovableLogo,
            sizing: StackFit.loose,
            children: [
              SvgPicture.asset(
                _fOnboardImages[_dLogoIndex],
                fit: BoxFit.cover,
                height: 225,
                width: 225,
              ),
              // this widget is initially invisible
              AnimatedSlide(
                offset: _dBlueLogoOffset,
                duration: const Duration(
                  milliseconds: 1000,
                ),
                curve: Curves.easeOutCirc,
                child: Assets.svgs.branding.logoWhiteBg.svg(
                  fit: BoxFit.cover,
                  height: 225,
                  width: 225,
                ),
              ),
            ],
          ),

          AnimatedSlide(
            offset: _dTextOffset,
            duration: const Duration(
              milliseconds: 1000,
            ),
            curve: Curves.easeOutCirc,
            child: Assets.svgs.branding.logoText.svg(
              height: 38,
              width: 266,
            ),
          ),
        ],
      ),
    );
  }

  /// This is an utility method to start Timer and run all the animations
  void _startAnimation() {
    _fSplashLogoTimer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        //the timer only runs twice (1000 milliseconds each) to swap the opacity
        if (_dOpacitySwapCount < 2) {
          if (mounted) {
            setState(() {
              if (_dOpacitySwapCount > 0) {
                // This indicate that it is the first time of running the animation
                // use the same 0 index, do not increase it
                _dLogoIndex++;
              }
              _dOpacitySwapCount++;
              _dOpacityVisible = !_dOpacityVisible;
            });
          }
        } else {
          //after the opacity part is finished
          _fSplashLogoTimer.cancel(); //we no longer need this timer
          if (mounted) {
            setState(() {
              //make the central blue logo with animation slide off the screen visible
              _dMovableLogo = 1;
              _dTextVisible =
                  !_dTextVisible; //make the playkosmos text visible from the centre
            });
          }
          Timer(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() {
                //wait for 100 ms and then set the new Offset for
                //playkosmos text and the blue logo
                _dTextOffset = const Offset(0, 0);
                _dBlueLogoOffset = Offset(-context.getDeviceWidth, 0);
              });
            }
          });
          //since the previous animation for the playkosmos logo
          //and text starts after the last timer call and it runs for 1000ms
          // (using AnimatedSlider) wait for 100ms and move to the language screen
          Timer(const Duration(milliseconds: 1100), () {
            // Mark the initialization phase finish
            context.push(const SelectLanguageView());
          });
        }
      },
    );
  }
}
