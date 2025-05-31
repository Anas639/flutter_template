import 'package:dio/dio.dart';
import 'package:flutter_template/features/auth/data/api/services/auth_service.dart';
import 'package:flutter_template/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_template/features/auth/domain/constraints.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

Future<void> registerAuthDependencies({
  required Dio dio,
  required int minPasswordLength,
}) async {
  serviceLocator.registerSingleton<AuthDomainConstraints>(
    AuthDomainConstraints(
      minPasswordLength: minPasswordLength,
    ),
  );
  serviceLocator.registerSingleton<AuthService>(AuthService(dio));
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      service: serviceLocator.get<AuthService>(),
    ),
  );
  serviceLocator.registerFactory<LoginUC>(
    () => LoginUC(
      repository: serviceLocator.get<AuthRepository>(),
      sessionService: serviceLocator.get<UserSessionService>(),
    ),
  );
}
