import 'package:flutter_template/features/auth/data/dto/user_dto.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends BaseApiResponse {
  UserDto? data;

  AuthResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory AuthResponse.fromJson(JSON json) => _$AuthResponseFromJson(json);
  @override
  JSON toJson() => _$AuthResponseToJson(this);
}
