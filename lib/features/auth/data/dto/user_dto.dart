import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  final String email;
  final String name;
  final String profilePicture;
  final String? token;

  const UserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.profilePicture,
    this.token,
  });

  factory UserDto.fromJson(JSON json) => _$UserDtoFromJson(json);
  JSON toJson() => _$UserDtoToJson(this);
}
