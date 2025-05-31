import 'dart:async';

import 'package:flutter_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/domain/use_case.dart';
import 'package:flutter_template/packages/core/session/session_data.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

typedef LoginParams = ({
  String email,
  String password,
});

class LoginUC implements UseCase2<LoginParams, Failure?> {
  const LoginUC({
    required this.repository,
    required this.sessionService,
  });

  final AuthRepository repository;
  final UserSessionService sessionService;

  @override
  Future<Failure?> call(LoginParams input) async {
    final response = await repository.login(
      email: input.email,
      password: input.password,
    );

    return response.fold(
      (l) => l,
      (user) {
        sessionService.createSession(
          SessionData.create(
            token: user.token ?? '',
            userId: user.id.toString(),
            info: user.toJson(),
          ),
        );
        return null;
      },
    );
  }
}
