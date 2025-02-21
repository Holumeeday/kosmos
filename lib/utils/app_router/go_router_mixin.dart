import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/data/repositories/buddies_remote_api_repository.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/account_information/view/account_email/account_info_email.dart';
import 'package:playkosmos_v3/ui/account_information/view/account_information.dart';
import 'package:playkosmos_v3/ui/account_information/view/account_phone/account_information_phone.dart';
import 'package:playkosmos_v3/ui/auth_provider/auth_provider_page.dart';
import 'package:playkosmos_v3/ui/buddies/cubit/buddies_cubit.dart';
import 'package:playkosmos_v3/ui/buddies/view/buddies_page.dart';
import 'package:playkosmos_v3/ui/buddy_activities/activity_details.dart';
import 'package:playkosmos_v3/ui/buddy_activities/buddy_activities.dart';
import 'package:playkosmos_v3/ui/buddy_activities/cubit/buddy_activities_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_connections/cubit/buddy_connections_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_connections/view/buddy_connections.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/view/buddy_profile_page.dart';
import 'package:playkosmos_v3/ui/create_password/cubit/create_password_cubit.dart';
import 'package:playkosmos_v3/ui/create_password/view/create_password_page.dart';
import 'package:playkosmos_v3/ui/edit_review/cubit/edit_review_cubit.dart';
import 'package:playkosmos_v3/ui/edit_review/view/edit_review.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/cubit/email_otp_verification_cubit.dart';
import 'package:playkosmos_v3/ui/email_otp_verification/view/email_otp_verification_page.dart';
import 'package:playkosmos_v3/ui/forgot_password_email/cubit/forgot_password_email_cubit.dart';
import 'package:playkosmos_v3/ui/forgot_password_email/view/forgot_password_email_page.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/cubit/forgot_password_otp_cubit.dart';
import 'package:playkosmos_v3/ui/forgot_password_otp/view/forgot_password_otp_page.dart';
import 'package:playkosmos_v3/ui/forgot_password_phone/cubit/forgot_password_phone_cubit.dart';
import 'package:playkosmos_v3/ui/forgot_password_phone/view/forgot_password_phone_page.dart';
import 'package:playkosmos_v3/ui/gallery_or_profile_picture/gallery_profile_pic_view.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';
import 'package:playkosmos_v3/ui/main/view/main_page.dart';
import 'package:playkosmos_v3/ui/onboarding/view/onboard_page.dart';
import 'package:playkosmos_v3/ui/phone_number_otp_verification%20copy/cubit/phone_number_otp_verification_cubit.dart';
import 'package:playkosmos_v3/ui/phone_number_otp_verification%20copy/view/phone_number_otp_verification_page.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/profile_creation_flow_page.dart';
import 'package:playkosmos_v3/ui/profile_menu/view/profile_menu_page.dart';
import 'package:playkosmos_v3/ui/reset_password_page/cubit/reset_password_cubit.dart';
import 'package:playkosmos_v3/ui/reset_password_page/view/reset_password_page.dart';
import 'package:playkosmos_v3/ui/reviews/cubit/reviews_cubit.dart';
import 'package:playkosmos_v3/ui/reviews/view/reviews.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';
import 'package:playkosmos_v3/ui/select_language/view/select_language_page.dart';
import 'package:playkosmos_v3/ui/sign_in_email/cubit/sign_in_cubit.dart';
import 'package:playkosmos_v3/ui/sign_in_email/view/sign_in_email_page.dart';
import 'package:playkosmos_v3/ui/sign_in_phone/cubit/sign_in_phone_cubit.dart';
import 'package:playkosmos_v3/ui/sign_in_phone/view/sign_in_phone_page.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/cubit/sign_up_phone_number_cubit.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/view/sign_up_phone_number_page.dart';
import 'package:playkosmos_v3/ui/signup_with_email/cubit/sign_up_with_email_cubit.dart';
import 'package:playkosmos_v3/ui/signup_with_email/view/sign_up_with_email_page.dart';
import 'package:playkosmos_v3/ui/splash/splash_page.dart';
import 'package:playkosmos_v3/utils/location_manager.dart';
import 'package:playkosmos_v3/utils/utils.dart';

import '../../ui/account_information/cubit/account_information_cubit.dart';
import '../../ui/account_information/view/account_email/add_email_page.dart';
import '../../ui/account_information/view/account_password/account_information_password..dart';

mixin GoRouterMixin {
  /// To create a go router route
  GoRoute createGoRoute({
    required String path,
    required String name,
    FutureOr<bool> Function(BuildContext, GoRouterState state)? onExit,
  }) {
    return GoRoute(
      parentNavigatorKey: GetContext.navigatorKey,
      path: path,
      name: name,
      onExit: onExit,
      pageBuilder: (context, state) => _buildRoutePage(context, state, path),
    );
  }

  /// To build a go router route page depending on the platform
  Page<dynamic> _buildRoutePage(
      BuildContext context, GoRouterState state, String path) {
    final bool isIos = context.isPlatformIos();
    if (isIos) {
      return CupertinoPage<void>(
        key: state.pageKey,
        child: _route(state, path),
      );
    } else {
      return MaterialPage<void>(
        key: state.pageKey,
        child: _route(state, path),
      );
    }
  }

  /// The route
  Widget _route(GoRouterState state, String path) {
    switch (path) {
      case AppRoute.splashScreenPath:
        return _createRoute(routeScreen: const SplashPage());
      case AppRoute.onboardingScreenPath:
        return _createRoute(routeScreen: const OnboardPage());
      case AppRoute.authProviderScreenPath:
        final isSignUp =
            bool.tryParse(state.uri.queryParameters['is-sign-up'] ?? '');
        return _createRoute(
            routeScreen: AuthProviderPage(fIsSignUp: isSignUp ?? false));
      case AppRoute.signUpEmailScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => SignUpWithEmailCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const SignUpWithEmailPage(),
          ),
        );
      case AppRoute.signUpPhoneScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => SignUpWithPhoneNumberCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const SignUpPhoneNumberPage(),
          ),
        );
      case AppRoute.signInEmailScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => SignInWithEmailCubit(
              fUserStorage: context.read<UserProfileStorage>(),
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const SignInEmailPage(),
          ),
        );
      case AppRoute.signInPhoneScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => SignInPhoneCubit(
              fUserStorage: context.read<UserProfileStorage>(),
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const SignInPhoneNumberPage(),
          ),
        );
      case AppRoute.forgotPasswordEmailScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ForgotPasswordEmailCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const ForgotPasswordEmailPage(),
          ),
        );
      case AppRoute.forgotPasswordPhoneScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ForgotPasswordPhoneCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const ForgotPasswordPhonePage(),
          ),
        );
      case AppRoute.forgotPasswordOtpScreenPath:
        final fQueryParams = state.uri.queryParameters;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ForgotPasswordOtpVerificationCubit(
              fEmail: fQueryParams['email'],
              fPhone: fQueryParams['phone'],
              fIsEmail: bool.parse(fQueryParams['is-email']!),
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: ForgotPasswordOtpVerificationPage(
              fEmail: fQueryParams['email'],
              fPhone: fQueryParams['phone'],
              fIsEmail: bool.parse(fQueryParams['is-email']!),
            ),
          ),
        );
      case AppRoute.emailOtpVerificationScreenPath:
        final fEmail = state.uri.queryParameters['email'] ?? '';
         print('Navigated to emailOtpVerification with email: $fEmail');
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => EmailOtpVerificationCubit(
              fEmail: fEmail,
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: EmailOtpVerificationPage(fEmail: fEmail),
          ),
        );
      case AppRoute.createPasswordScreenPath:
        final fQueryParams = state.uri.queryParameters;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => CreatePasswordCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: CreatePasswordPage(
              fEmail: fQueryParams['email'] ?? '',
              fPhone: fQueryParams['phone'] ?? '',
              fIsEmail: bool.parse(fQueryParams['is-email']!),
            ),
          ),
        );
      case AppRoute.galleryOrProfilePicturesScreenPath:
        return _createRoute(
            routeScreen:
                const GalleryProfilePicPage(fSelectedAssetEntity: null));
      case AppRoute.homeScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => MainPageCubit(),
            child: const MainPage(),
          ),
        );
      case AppRoute.selectLanguageScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => SelectLanguageCubit(),
            child: const SelectLanguagePage(),
          ),
        );
      case AppRoute.resetPasswordScreenPath:
        final fQueryParams = state.uri.queryParameters;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ResetPasswordCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: ResetPasswordPage(
              fEmail: fQueryParams['email'],
              fPhone: fQueryParams['phone'],
              fIsEmail: bool.parse(fQueryParams['is-email']!),
            ),
          ),
        );
      case AppRoute.phoneNumberOtpVerificationScreenPath:
        final fPhone = state.uri.queryParameters['phone'] ?? '';
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => PhoneNumberOtpVerificationCubit(
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
              fPhone: fPhone,
            ),
            child: PhoneNumberOtpVerificationPage(fPhone: fPhone),
          ),
        );
      case AppRoute.profileCreationFlowScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ProfileCreationFlowCubit(
              fUserRepository: context.read<UserProfileStorage>(),
              fAuthRepository: context.read<AuthRemoteApiRepository>(),
            ),
            child: const ProfileCreationFlowPage(),
          ),
        );
      case AppRoute.homeBuddiesScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => BuddiesCubit(
              fLocationManager: context.read<LocationManager>(),
              fBuddiesRepository: context.read<BuddiesRemoteApiRepository>(),
            ),
            child: const BuddiesPage(),
          ),
        );
      case AppRoute.buddyConnectionsScreenPath:
        final fInitIndex = state.extra as int;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => BuddyConnectionsCubit(),
            child: BuddyConnectionsPage(fInitialIndex: fInitIndex),
          ),
        );
      case AppRoute.buddyProfileScreenPath:
        final fBuddyId = state.extra as String;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => BuddyProfileCubit(),
            child: BuddyProfilePage(buddyId: fBuddyId),
          ),
        );
      case AppRoute.reviewsScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => ReviewsCubit(),
            child: const ReviewsPage(),
          ),
        );
      case AppRoute.buddyActivitiesScreenPath:
        final fIsCreator = state.extra as bool;
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => BuddyActivitiesCubit(),
            child: BuddyActivitiesPage(fIsCreator: fIsCreator),
          ),
        );
      case AppRoute.activityDetailsScreenPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => BuddyActivitiesCubit(),
            child: const ActivityDetailsPage(),
          ),
        );
      case AppRoute.editReviewPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => EditReviewCubit(),
            child: const EditReviewPage(),
          ),
        );
      case AppRoute.profileMenuPagePath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => MainPageCubit(),
            child: const ProfileMenuPage(),
          ),
        );
      case AppRoute.accountInformationPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => AccountInformationCubit(),
            child: const AccountInformationPage(),
          ),
        );
      case AppRoute.accountInformationemailPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => AccountInformationCubit(),
            child: const AccountInfomationEmailPage(),
          ),
        );
      case AppRoute.accountInformationphonePath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => AccountInformationCubit(),
            child: const AccountInformationPhonePage(),
          ),
        );
      case AppRoute.accountInformationpasswordPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => AccountInformationCubit(),
            child: const AccountInformationPasswordPage(),
          ),
        );
      case AppRoute.addemailPath:
        return _createRoute(
          routeScreen: BlocProvider(
            create: (context) => AccountInformationCubit(),
            child: const AddEmailPage(),
          ),
        );
      default:
        return _createRoute(routeScreen: const SplashPage());
    }
  }

  /// To create a route
  Widget _createRoute({
    required Widget routeScreen,
  }) {
    return Builder(
      builder: (context) {
        return routeScreen;
      },
    );
  }
}
