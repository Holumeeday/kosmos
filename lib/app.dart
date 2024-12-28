import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/ui/buddies/cubit/buddies_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_connections/cubit/buddy_connections_cubit.dart';
import 'package:playkosmos_v3/ui/buddy_profile/cubit/buddy_profile_cubit.dart';
import 'package:playkosmos_v3/ui/main/cubit/main_page_cubit.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';
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
    required this.fCookiesStorage,
  });

  /// The non-secure storage repository for app data storage
  final NonSecureStorage fNonSecureStorage;

  /// The app cookies storage
  final CookiesStorage fCookiesStorage;

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
            fCookiesStorage: fCookiesStorage,
          ),
        ),
        RepositoryProvider(
          create: (context) => UserProfileStorage(
            fStorage: fNonSecureStorage,
          ),
        ),
        RepositoryProvider(
          create: (context) => PermissionsRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRemoteApiRepository(
            remoteApi: AuthRemoteApiNodeJs(
              fCookStorage: fCookiesStorage,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => AppRoute(
            fAuthStorage: context.read<AuthFlowStorage>(),
          ),
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
          create: (_) => MainPageCubit(),
        ),
        BlocProvider(
          create: (_) => BuddiesCubit(),
        ),
        BlocProvider(
          create: (_) => BuddyProfileCubit(),
        ),
        BlocProvider(
          create: (_) => BuddyConnectionsCubit(),
        )
      ],
      child: const _AppView(),
    );
  }
}

/// Main app view widget that configures the MaterialApp with themes, locale,
/// and localization
class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late GoRouter _fRouter;

  @override
  void initState() {
    super.initState();
    _fRouter = context.read<AppRoute>().router;
  }

  @override
  Widget build(BuildContext context) {
    final dLocale = context
        .select((SelectLanguageCubit cubit) => cubit.state.dSelectedLocale);
    return MaterialApp.router(
      routerConfig: _fRouter,
      title: 'Playkosmos',
      debugShowCheckedModeBanner: false,
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
