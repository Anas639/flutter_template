import 'package:flutter/material.dart';
import 'package:flutter_template/features/settings/presentatin/widgets/dark_mode_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Text(
            "Theme",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            title: Text("Dark Mode"),
            trailing: DarkModeSwitch(),
          ),
        ],
      ),
    );
  }
}
