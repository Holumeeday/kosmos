import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/ui/select_language/cubit/select_language_cubit.dart';
import 'package:playkosmos_v3/ui/splash/splash_view.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/// This widget is used to setup all the global view models
/// to be used in the app
///
/// @author: Godwin Mathias
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SelectLanguageCubit(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final dLocale = context
        .select((SelectLanguageCubit cubit) => cubit.state.dSelectedLocale);
    return MaterialApp(
      title: 'Playkosmos',
      navigatorKey: GetContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      builder: DevicePreview.appBuilder,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      locale: dLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
