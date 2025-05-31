import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/di.dart';
import 'package:flutter_template/features/settings/presentatin/store/settings_store.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/router.dart';

void main() async {
  await injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final useDarkMode = serviceLocator.get<SettingsStore>().useDarkMode;
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      darkTheme: AppTheme.getDarktheme(),
      theme: AppTheme.getLightTheme(),
      themeMode: useDarkMode.watch(context) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
