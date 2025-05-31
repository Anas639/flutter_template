import 'package:flutter/material.dart';

import '../../di/service_locator.dart';
import '../../session/user_session.dart';
import '../dialogs/confirmation_dialog.dart';

/// An Icon Button that clears the session when pressed
///
/// *i.e.* **Logout**
class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmationDialog(
              message: "Do you wan't to leave? 😢",
              title: 'Nooooooooo!',
              confirmLabel: 'Leave',
              cancelLabel: 'Stay',
              onConfirm: () {
                serviceLocator.get<UserSessionService>().destroySession();
              },
            );
          },
        );
      },
      icon: Icon(
        Icons.logout_rounded,
      ),
    );
  }
}
