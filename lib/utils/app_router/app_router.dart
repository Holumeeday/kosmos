import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/services/services.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class defines the routes and path names for the app navigation
@author: Godwin Mathias
*/
class AppRoute with GoRouterMixin {
  AppRoute();

  /// The auth service
  final AuthStorageService _fAuthService = locator<AuthStorageService>();

  /// The router
  GoRouter get router => GoRouter(
        observers: [GoRouterObserver()],
        initialLocation: splashScreenPath,
        navigatorKey: GetContext.navigatorKey,
        refreshListenable: _fAuthService.listenable,
        debugLogDiagnostics: true,
        routes: [
          createGoRoute(
            path: splashScreenPath,
            name: splashScreen,
          ),
        ],
        redirect: (context, state) {
          /// Pages used for authentication
          const List<String> authPages = [];

          /// Pages used in step 2
          const List<String> step2Pages = [];

          /// Check the login state
          final bool isLoggedIn = _fAuthService.fAuthModel.isLoggedIn;

          /// Check if the user has gone through the splash
          final bool isInitialized = _fAuthService.fAuthModel.isInitialized;

          /// Check if user has gone through the onboard screen
          final bool isOnboarded = _fAuthService.fAuthModel.isOnboarded;

          /// Check if user has gone through the otp verification screen
          final bool isVerified = _fAuthService.fAuthModel.isVerified;

          /// Checks if the user has completed the step 2 process of creating
          /// an account
          final bool hasCompletedStep2 =
              _fAuthService.fAuthModel.hasCompletedStep2;

          /// Check if user going to splash screen
          final bool isGoingToInit = state.matchedLocation == splashScreenPath;

          /// If the user is going to any of the auth pages
          final bool isGoingToAuthPages =
              authPages.contains(state.matchedLocation);

          /// If the user is going to any of the step 2 pages
          final bool isGoingToStep2Pages =
              step2Pages.contains(state.matchedLocation);

          /// Checks if the user is going to the onboarding page
          final bool isGoingToOnboard = state.matchedLocation == '';

          /// Checks if the user is going to the otp verification page
          final bool isGoingToVerify = state.matchedLocation == '';

          /// If not initialized, redirect to Splash
          if (!isInitialized) {
            return splashScreenPath;

            /// If initialized but not onboarded, redirect to Select Language
          } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
            return '';

            /// If initialized and onboarded only, redirect to create Account if
            /// user is not going to the auth pages else redirect to login
          } else if (isInitialized && isOnboarded && !isLoggedIn) {
            if (isVerified && hasCompletedStep2) {
              return isGoingToAuthPages ? null : '';
            }
            return isGoingToAuthPages ? null : '';

            /// If its not verified redirect to verify otp screen
          } else if (isInitialized &&
              isOnboarded &&
              isLoggedIn &&
              !isVerified &&
              !hasCompletedStep2) {
            return isGoingToVerify ? null : '';

            /// If all true but has not completed step 2 and is not going to
            /// profile and pic page, redirect to Profile Pic and Bio
          } else if (isInitialized &&
              isOnboarded &&
              isLoggedIn &&
              isVerified &&
              !hasCompletedStep2) {
            return isGoingToStep2Pages ? null : '';

            /// if everything is set, send the user where they were going before (or
            /// home if they weren't going anywhere i.e They're in /splash)
          } else if (_fAuthService.fAuthModel.allTrue()) {
            /// Only redirect the user to home on app launch
            if (isGoingToInit) return '';

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

  /// Route names
  ///
  static const String splashScreen = 'splash';
}
