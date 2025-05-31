// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserDtoCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// UserDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserDto call({
    int id,
    String email,
    String password,
    String name,
    String profilePicture,
    String? token,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserDto.copyWith(...)`.
class _$UserDtoCWProxyImpl implements _$UserDtoCWProxy {
  const _$UserDtoCWProxyImpl(this._value);

  final UserDto _value;

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// UserDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? profilePicture = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return UserDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      profilePicture: profilePicture == const $CopyWithPlaceholder()
          ? _value.profilePicture
          // ignore: cast_nullable_to_non_nullable
          : profilePicture as String,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
    );
  }
}

extension $UserDtoCopyWith on UserDto {
  /// Returns a callable class that can be used as follows: `instanceOfUserDto.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$UserDtoCWProxy get copyWith => _$UserDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'token': instance.token,
    };
