import 'package:flutter/material.dart';
import 'package:flutter_template/features/settings/presentatin/widgets/settings_icon.dart';
import 'package:flutter_template/features/user/presentation/widgets/user_appbar_widget.dart';
import 'package:flutter_template/packages/core/ui/widgets/logout_icon.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UserAppbarWidget(),
        actions: [
          SettingsIcon(),
          LogoutIcon(),
        ],
      ),
      body: child,
    );
  }
}
