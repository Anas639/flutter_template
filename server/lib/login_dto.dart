import 'package:json_annotation/json_annotation.dart';
import 'package:server/types.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  final String email;
  final String password;

  const LoginDto({
    required this.email,
    required this.password,
  });

  factory LoginDto.fromJson(JSON json) => _$LoginDtoFromJson(json);
  JSON toJson() => _$LoginDtoToJson(this);
}
