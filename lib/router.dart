import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/presentation/routes/routes.dart';
import 'package:flutter_template/features/settings/presentatin/routes/routes.dart';
import 'package:flutter_template/features/todo/presentation/routes/routes.dart';
import 'package:flutter_template/main_shell.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';
import 'package:flutter_template/settings_shell.dart';
import 'package:go_router/go_router.dart';

class AuthListenable extends ChangeNotifier {
  late final StreamSubscription _subscription;
  AuthListenable() {
    _subscription = serviceLocator.get<UserSessionService>().sessionStream.listen((_) {
      notifyListeners();
    });
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

FutureOr<String?> routerRedirectHandler(BuildContext context, GoRouterState state) {
  final isAuthenticated = serviceLocator.get<UserSessionService>().isAuthenticated;
  if (!isAuthenticated) {
    return "/login";
  }

  if (state.fullPath == '/login') {
    return '/todos';
  }
  return null;
}

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey();

final router = GoRouter(
  refreshListenable: AuthListenable(),
  redirect: routerRedirectHandler,
  initialLocation: '/login',
  routes: [
    ...AuthRoutes.routes,
    ShellRoute(
      routes: SettingsRoutes.routes,
      builder: (context, state, child) {
        return SettingsShell(child: child);
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: TodoRoutes.routes,
      builder: (context, state, child) {
        return MainShell(
          child: child,
        );
      },
    ),
  ],
);
