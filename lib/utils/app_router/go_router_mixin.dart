import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/splash/splash_view.dart';
import 'package:playkosmos_v3/utils/utils.dart';

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
        return _createRoute(
          routeScreen: const SplashView(),
        );
      default:
        return _createRoute(
          routeScreen: const SplashView(),
        );
    }
  }

  ///To create a route
  ///
  ///Accepts the name of the route [routeName] and the screen it points to
  ///[routeScreen]
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
