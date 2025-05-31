import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/domain/entities/user.dart';
import 'package:flutter_template/features/user/presentation/widgets/user_avatar.dart';
import 'package:flutter_template/packages/core/di/service_locator.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';
import 'package:flutter_template/packages/core/types/types.dart';

class SettingsShell extends StatelessWidget {
  const SettingsShell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            initialData: serviceLocator.get<UserSessionService>().session,
            stream: serviceLocator.get<UserSessionService>().sessionStream,
            builder: (context, snapshot) {
              User? u;
              try {
                JSON? json = snapshot.data?.info;
                if (json != null) {
                  u = User.fromJson(json);
                }
              } catch (_) {}
              return UserAvatar(
                url: u?.profilePicture ?? '',
                size: 100,
              );
            },
          ),
          child,
        ],
      ),
    );
  }
}
