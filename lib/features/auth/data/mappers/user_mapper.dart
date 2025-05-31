import 'package:flutter_template/features/auth/data/dto/user_dto.dart';
import 'package:flutter_template/features/auth/domain/entities/user.dart';
import 'package:flutter_template/packages/core/core.dart';

class UserMapper implements DataMapper<User, UserDto> {
  @override
  UserDto toData(User domain) {
    return UserDto(
      id: domain.id,
      name: domain.name,
      email: domain.email,
      profilePicture: domain.profilePicture,
      token: domain.token,
    );
  }

  @override
  User toDomain(UserDto data) {
    return User(
      token: data.token,
      profilePicture: data.profilePicture,
      email: data.email,
      name: data.name,
      id: data.id,
    );
  }
}
