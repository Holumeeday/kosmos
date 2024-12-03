import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/ui/select_language/select_language_view_model.dart';
import 'package:playkosmos_v3/ui/splash/splash_view.dart';
import 'package:playkosmos_v3/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all service with [GetIt]
  await setupLocator();

  // Set the app orientation to portrait only mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (_) => const App(),
  ));
}

/// This widget is used to setup all the global view models
/// to be used in the app
///
/// @author: Godwin Mathias
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SelectLanguageViewModel(),
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
    final dLocale =
        context.select((SelectLanguageViewModel vm) => vm.dSelectedLocale);
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
