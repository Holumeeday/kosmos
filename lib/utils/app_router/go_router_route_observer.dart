import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/utils/get_context.dart';

/*
Route observer for the entire app
author: Godwin Mathias
*/
class GoRouterObserver extends NavigatorObserver {
  /// List of screens to be in portrait mode
  static const portraitScreensPath = [];

  /// Track the previous page on pop
  ValueNotifier<String> lastPage = ValueNotifier('/');
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (portraitScreensPath.contains(currentLocation)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    lastPage.value = currentLocation;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Only set orientation back if the pop pages are the portrait pages and the current
    // page isn't in the list of portrait pages

    if (portraitScreensPath.contains(lastPage.value) &&
        !portraitScreensPath.contains(currentLocation)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Only set orientation back if the pop pages are the portrait pages and the current
    // page isn't in the list of portrait pages
    if (portraitScreensPath.contains(lastPage.value) &&
        !portraitScreensPath.contains(currentLocation)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // Only set orientation back if the pop pages are the portrait pages and the current
    // page isn't in the list of portrait pages
    if (portraitScreensPath.contains(lastPage.value) &&
        !portraitScreensPath.contains(currentLocation)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.didReplace();
  }

  /// Get the current route path
  String get currentLocation {
    final RouteMatch lastMatch = GoRouter.of(GetContext.current)
        .routerDelegate
        .currentConfiguration
        .last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : GoRouter.of(GetContext.current).routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
