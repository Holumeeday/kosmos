import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Used to remove every suffix of a path i.e path parameters or query parameters
/// for example /email-page/:email is cleaned to /email-page
extension _StringX on String {
  String get cleanPath => '/${split('/')[1]}';
}

/*
This class defines the routes and path names for the app navigation
@author: Godwin Mathias
*/
class AppRoute with GoRouterMixin {
  AppRoute({
    required AuthFlowStorage fAuthStorage,
  }) : _fAuthFlowStorage = fAuthStorage;

  /// The auth service
  final AuthFlowStorage _fAuthFlowStorage;

  /// The router
  GoRouter get router => GoRouter(
        initialLocation: splashScreenPath,
        navigatorKey: GetContext.navigatorKey,
        refreshListenable: StreamListenable(_fAuthFlowStorage.listener, null),
        debugLogDiagnostics: true,
        routes: [
          createGoRoute(
            path: splashScreenPath,
            name: splashScreen,
          ),
          createGoRoute(
            path: homeScreenPath,
            name: homeScreen,
          ),
          createGoRoute(
            path: authProviderScreenPath,
            name: authProviderScreen,
          ),
          createGoRoute(
            path: signInEmailScreenPath,
            name: signInEmailScreen,
          ),
          createGoRoute(
            path: signInPhoneScreenPath,
            name: signInPhoneScreen,
          ),
          createGoRoute(
            path: signUpEmailScreenPath,
            name: signUpEmailScreen,
          ),
          createGoRoute(
            path: signUpPhoneScreenPath,
            name: signUpPhoneScreen,
          ),
          createGoRoute(
            path: forgotPasswordEmailScreenPath,
            name: forgotPasswordEmailScreen,
          ),
          createGoRoute(
            path: forgotPasswordPhoneScreenPath,
            name: forgotPasswordPhoneScreen,
          ),
          createGoRoute(
            path: forgotPasswordOtpScreenPath,
            name: forgotPasswordOtpScreen,
          ),
          createGoRoute(
            path: emailOtpVerificationScreenPath,
            name: emailOtpVerificationScreen,
          ),
          createGoRoute(
            path: phoneNumberOtpVerificationScreenPath,
            name: phoneNumberOtpVerificationScreen,
          ),
          createGoRoute(
            path: galleryOrProfilePicturesScreenPath,
            name: galleryOrProfilePicturesScreen,
          ),
          createGoRoute(
            path: profileCreationFlowScreenPath,
            name: profileCreationFlowScreen,
          ),
          createGoRoute(
            path: selectLanguageScreenPath,
            name: selectLanguageScreen,
          ),
          createGoRoute(
            path: onboardingScreenPath,
            name: onboardingScreen,
          ),
          createGoRoute(
            path: createPasswordScreenPath,
            name: createPasswordScreen,
          ),
        ],
        redirect: (context, state) {
          /// Pages used for authentication
          final List<String> authPages = [
            signInEmailScreenPath.cleanPath,
            signInPhoneScreenPath.cleanPath,
            signUpEmailScreenPath.cleanPath,
            signUpPhoneScreenPath.cleanPath,
            forgotPasswordEmailScreenPath.cleanPath,
            forgotPasswordPhoneScreenPath.cleanPath,
            forgotPasswordOtpScreenPath.cleanPath,
            emailOtpVerificationScreenPath.cleanPath,
            authProviderScreenPath.cleanPath,
            createPasswordScreenPath.cleanPath,
            phoneNumberOtpVerificationScreenPath.cleanPath,
          ];

          /// Pages used in step 2
          final List<String> step2Pages = [
            galleryOrProfilePicturesScreenPath.cleanPath,
            profileCreationFlowScreenPath.cleanPath,
          ];

          /// Check the login state
          final bool isLoggedIn = _fAuthFlowStorage.fAuthModel.isLoggedIn;

          /// Check if the user has gone through the splash
          final bool isInitialized = _fAuthFlowStorage.fAuthModel.isInitialized;

          /// Check if user has gone through the onboard screen
          final bool isOnboarded = _fAuthFlowStorage.fAuthModel.isOnboarded;

          /// Checks if the user has completed the step 2 process of creating
          /// an account
          final bool hasCompletedStep2 =
              _fAuthFlowStorage.fAuthModel.hasCompletedStep2;

          /// Check if user going to splash screen
          final bool isGoingToInit = state.matchedLocation == splashScreenPath;

          /// If the user is going to any of the auth pages
          final bool isGoingToAuthPages =
              authPages.contains(state.matchedLocation.cleanPath);

          /// If the user is going to any of the step 2 pages
          final bool isGoingToStep2Pages =
              step2Pages.contains(state.matchedLocation.cleanPath);

          /// Checks if the user is going to the onboarding page
          final bool isGoingToOnboard =
              state.matchedLocation.cleanPath == onboardingScreenPath;

          /// If not initialized, redirect to Splash
          if (!isInitialized) {
            return splashScreenPath;

            /// If initialized but not onboarded, redirect to Select Language
          } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
            return selectLanguageScreenPath;

            /// If initialized and onboarded only, redirect to create Account if
            /// user is not going to the auth pages else redirect to login
          } else if (isInitialized && isOnboarded && !isLoggedIn) {
            if (hasCompletedStep2) {
              return isGoingToAuthPages ? null : authProviderScreenPath;
            }
            return isGoingToAuthPages ? null : authProviderScreenPath;

            /// If all true but has not completed step 2 and is not going to
            /// profile and pic page, redirect to Profile Pic and Bio
          } else if (isInitialized &&
              isOnboarded &&
              isLoggedIn &&
              !hasCompletedStep2) {
            return isGoingToStep2Pages ? null : profileCreationFlowScreenPath;

            /// if everything is set, send the user where they were going before (or
            /// home if they weren't going anywhere i.e They're in /splash)
          } else if (_fAuthFlowStorage.fAuthModel.allTrue()) {
            /// Only redirect the user to home on app launch
            if (isGoingToInit) return homeScreenPath;

            /// No redirection needed this time
            return null;
          } else {
            // Else Don't do anything
            return null;
          }
        },
      );

  /// Route paths
  ///
  static const String splashScreenPath = '/';
  static const String homeScreenPath = '/home';
  static const String authProviderScreenPath = '/auth-provider';
  static const String signUpEmailScreenPath = '/sign-up-email';
  static const String signUpPhoneScreenPath = '/sign-up-phone';
  static const String signInEmailScreenPath = '/sign-in-email';
  static const String signInPhoneScreenPath = '/sign-in-phone';
  static const String createPasswordScreenPath = '/create-password';
  static const String emailOtpVerificationScreenPath =
      '/email-otp-verification/:email';
  static const String forgotPasswordEmailScreenPath = '/forgot-password-email';
  static const String forgotPasswordOtpScreenPath = '/forgot-password-otp';
  static const String forgotPasswordPhoneScreenPath = '/forgot-password-phone';
  static const String galleryOrProfilePicturesScreenPath = '/gallery-pictures';
  static const String onboardingScreenPath = '/onboarding';
  static const String phoneNumberOtpVerificationScreenPath =
      '/phone-otp-verification/:phone';
  static const String profileCreationFlowScreenPath = '/profile-creation-flow';
  static const String resetPasswordScreenPath = '/reset-password';
  static const String selectLanguageScreenPath = '/select-language';

  /// Route names
  ///
  static const String splashScreen = 'splash';
  static const String homeScreen = 'home';
  static const String authProviderScreen = 'auth-provider';
  static const String signUpEmailScreen = 'sign-up-email';
  static const String signUpPhoneScreen = 'sign-up-phone';
  static const String signInEmailScreen = 'sign-in-email';
  static const String signInPhoneScreen = 'sign-in-phone';
  static const String createPasswordScreen = 'create-password';
  static const String emailOtpVerificationScreen = 'email-otp-verification';
  static const String forgotPasswordEmailScreen = 'forgot-password-email';
  static const String forgotPasswordOtpScreen = 'forgot-password-otp';
  static const String forgotPasswordPhoneScreen = 'forgot-password-phone';
  static const String galleryOrProfilePicturesScreen = 'gallery-pictures';
  static const String onboardingScreen = 'onboarding';
  static const String phoneNumberOtpVerificationScreen =
      'phone-otp-verification';
  static const String profileCreationFlowScreen = 'profile-creation-flow';
  static const String resetPasswordScreen = 'reset-password';
  static const String selectLanguageScreen = 'select-language';
}

class StreamListenable extends ValueNotifier<dynamic> {
  StreamListenable(Stream<dynamic> stream, dynamic initialValue)
      : super(initialValue) {
    _subscription = stream.listen((event) {
      value = event;
    });
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
