import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playkosmos_v3/assets_gen/assets.gen.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/constants/constants.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// The authentication provider selection page
///
/// i.e for selecting, Google, Email or Phone sign in method
/// author: Godwin Mathias
class AuthProviderView extends StatelessWidget {
  const AuthProviderView({
    super.key,
    required this.fIsSignUp,
  });

  /// If this is a sign up attempt
  final bool fIsSignUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        fAppBarColor: Colors.transparent,
        fElevation: 0,
        fActions: [
          AuthHeaderChangeLocale(),
          const HSpace(12),
        ],
        fShowBackButton: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColor.fPrimaryGradient,
            stops: kScaffoldBgGradientStops,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const VSpace(60),
                const _AppLogoWithText(),
                const VSpace(40),
                _AuthProviderButtons(
                  fIsSignUp: fIsSignUp,
                ),
                const VSpace(100),

                // Login or Create account button
                const _GradientContainerWithText(),
                const VSpace(24),

                // Terms and condition
                const _TermsAndConditions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppLogoWithText extends StatelessWidget {
  const _AppLogoWithText();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const PlaykosmosLogoVertical(),
        const VSpace(8),
        Text(
          context.loc.exploreFunActivitiesNearbyAfar,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _AuthProviderButtons extends StatelessWidget {
  const _AuthProviderButtons({
    required this.fIsSignUp,
  });

  final bool fIsSignUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Sign up with Google
        _AuthButton(
          fOnPressed: () {},
          fAuthIcon: Assets.svgs.auth.google.svg(),
          fAuthText: fIsSignUp
              ? context.loc.signUpWithGoogle
              : context.loc.loginWithGoogle,
        ),
        const VSpace(20),

        // Sign up with Email
        _AuthButton(
          fOnPressed: () {},
          fAuthIcon: Assets.svgs.auth.emailGradient.svg(),
          fAuthText: fIsSignUp
              ? context.loc.signUpWithEmail
              : context.loc.loginWithEmail,
        ),
        const VSpace(20),

        // Sign up with Number
        _AuthButton(
          fOnPressed: () {},
          fAuthIcon: Assets.svgs.auth.phoneGradient.svg(),
          fAuthText: fIsSignUp
              ? context.loc.signUpWithNumber
              : context.loc.loginWithNumber,
        )
      ],
    );
  }
}

class _AuthButton extends StatelessWidget {
  const _AuthButton({
    required this.fOnPressed,
    required this.fAuthIcon,
    required this.fAuthText,
  });

  final VoidCallback fOnPressed;
  final Widget fAuthIcon;
  final String fAuthText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fOnPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: const Size(
            double.infinity,
            56,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          fAuthIcon,
          const HSpace(12),
          Flexible(
            child: Text(
              fAuthText,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientContainerWithText extends StatelessWidget {
  const _GradientContainerWithText();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
        gradient: const LinearGradient(
          stops: [
            .001,
            .001,
            .7,
          ],
          colors: AppColor.fPrimaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: RichText(
        text: TextSpan(
          text: '${context.loc.alreadyHaveAnAccount} ',
          style: context.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: context.loc.loginText,
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsAndConditions extends StatelessWidget {
  const _TermsAndConditions();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: context.loc.iUnderstandTandC,
        style: context.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: context.loc.termsAndConditions.toLowerCase(),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to terms & conditions page
                debugPrint('Terms & Conditions clicked');
              },
          ),
          const TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: context.loc.privacyPolicy.toLowerCase(),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              color: Colors.white,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to privacy policy page
              },
          ),
          const TextSpan(
            text: '.',
          ),
        ],
      ),
    );
  }
}
