import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:playkosmos_v3/extensions/context_extension.dart';

/// Used to get the current context of the app
class GetContext {
  /// The navigator key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The global context
  static BuildContext current = navigatorKey.currentContext!;

  /// The app localization
  static AppLocalizations get loc => current.loc;
}
