import 'package:flutter/material.dart';
import 'package:flutter_template/features/settings/presentatin/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';

class SettingsRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return SettingsScreen();
      },
    ),
  ];

  static Future openSettings(BuildContext context) {
    return context.push('/settings');
  }
}
