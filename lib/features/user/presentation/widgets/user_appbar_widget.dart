import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/domain/entities/user.dart';
import 'package:flutter_template/features/user/presentation/widgets/user_avatar.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/session/session_data.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

class UserAppbarWidget extends StatefulWidget {
  const UserAppbarWidget({super.key});

  @override
  State<UserAppbarWidget> createState() => _UserAppbarWidgetState();
}

class _UserAppbarWidgetState extends State<UserAppbarWidget> {
  User? user;
  StreamSubscription? subscription;
  @override
  void initState() {
    super.initState();
    var session = serviceLocator.get<UserSessionService>();
    subscription = session.sessionStream.listen(_onSessionChanged);
    _onSessionChanged(session.session);
  }

  void _onSessionChanged(SessionData? s) {
    try {
      JSON? json = s?.info;
      User? u;
      if (json != null) {
        u = User.fromJson(json);
      }
      setState(() {
        user = u;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = user?.name ?? '';
    final profilePicture = user?.profilePicture ?? '';

    return Row(
      spacing: 24,
      children: [
        if (profilePicture.isNotEmpty)
          UserAvatar(
            url: profilePicture,
          ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
