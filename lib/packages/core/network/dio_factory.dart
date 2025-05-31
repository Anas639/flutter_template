import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/packages/core/network/interceptors/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Cretes a [Dio] client with [baseUrl]
///
/// This factory will automatically add some interceptors
///
/// We might add some more parameters to this facotry to make it more customizable.
Dio createDioClient({required String baseUrl}) {
  final dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );
  dio.interceptors.add(authInterceptor());
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ),
  );

  return dio;
}
