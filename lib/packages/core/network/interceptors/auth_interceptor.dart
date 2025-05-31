import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

/// Intercepts [Dio] requests and adds Bearer token using [UserSessionService]
///
/// If you don't want a request to include the `Authorization` header
/// set the `no_auth` extra to true
///
/// Setting `no_auth` using `retrofit`:
/// ```dart
///   @POST('')
///   @Extra({
///     'no_auth': true,
///   })
///   Future<AuthResponse> login(@Body() LoginDto login);
/// ```
Interceptor authInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (!serviceLocator.isRegistered<UserSessionService>()) {
        handler.next(options);
        return;
      }
      bool noAuth = options.extra['no_auth'] ?? false;
      if (!noAuth) {
        String token = serviceLocator.get<UserSessionService>().session?.token ?? '';
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
    onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        if (error.response?.data != null) {
          try {
            final json = jsonDecode(error.response!.data);
            handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                data: json,
              ),
            );
            return;
          } catch (_, __) {}
        }
      }
      handler.next(error);
    },
  );
}
