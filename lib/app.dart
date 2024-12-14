import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';
import 'package:playkosmos_v3/ui/sign_up_phone_number/cubit/sign_up_phone_number_cubit.dart';
import 'package:playkosmos_v3/ui/splash/splash_page.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// Root widget of the application responsible for setting up global dependencies,
/// repository providers, and BLoC providers.
///
/// This widget sets up:
/// - Non-secure storage repository.
/// - Auth flow storage for managing authentication state.
///
/// @author: Godwin Mathias
class App extends StatelessWidget {
  const App({
    super.key,
    required this.fNonSecureStorage,
  });

  /// The non-secure storage repository for app data storage
  final NonSecureStorage fNonSecureStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: fNonSecureStorage,
        ),
        RepositoryProvider(
          create: (context) => AuthFlowStorage(
            fStorage: fNonSecureStorage,
          ),
        ),
        RepositoryProvider(
          create: (context) => PermissionsRepository(),
        ),
      ],
      child: const _AppBloc(),
    );
  }
}

/// This widget provides all BLoC providers for the application
class _AppBloc extends StatelessWidget {
  const _AppBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SelectLanguageCubit(),
        ),
        BlocProvider(
          create: (_) => SignUpWithPhoneNumberCubit(),
        ),
        BlocProvider(
          create: (_) => MainPageCubit(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

/// Main app view widget that configures the MaterialApp with themes, locale,
/// and localization
class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final dLocale = context
        .select((SelectLanguageCubit cubit) => cubit.state.dSelectedLocale);
    return MaterialApp(
      title: 'Playkosmos',
      navigatorKey: GetContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      builder: DevicePreview.appBuilder,
      // Enables device preview for development
      theme: MyThemes.lightTheme,
      // Light theme of the app
      darkTheme: MyThemes.darkTheme,
      // Dark theme of the app
      locale: dLocale,
      // Selected language/locale
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
