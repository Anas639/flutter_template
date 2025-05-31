import 'package:flutter/material.dart';
import 'package:flutter_template/features/settings/presentatin/routes/routes.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SettingsRoutes.openSettings(context);
      },
      icon: Icon(Icons.settings),
    );
  }
}
