import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/settings/presentatin/store/settings_store.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/di/service_locator.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsStore = serviceLocator.get<SettingsStore>();
    return Watch((context) {
      final useDarkMode = settingsStore.useDarkMode.value;
      return Switch(
        value: useDarkMode,
        onChanged: (value) {
          settingsStore.enableDarkMode(value);
        },
      );
    });
  }
}
