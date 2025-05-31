import 'package:dio/dio.dart';
import 'package:flutter_template/features/auth/data/api/response/auth_response.dart';
import 'package:flutter_template/features/auth/data/dto/login_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: 'login')
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) = _AuthService;
  @POST('')
  @Extra({
    'no_auth': true,
  })
  Future<AuthResponse> login(@Body() LoginDto login);
}
