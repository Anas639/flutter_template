import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:server/dto.dart';
import 'package:server/types.dart';

part 'user_dto.g.dart';

@JsonSerializable(createFactory: false)
@CopyWith(skipFields: true)
class UserDto implements ApiResponseData {
  final int id;
  final String email;
  final String password; // DONT'T DO THAT IN PRODUCTION 🤓
  final String name;
  final String profilePicture;
  final String? token;

  const UserDto({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.profilePicture,
    this.token,
  });

  @override
  JSON toJson() => _$UserDtoToJson(this);
}
