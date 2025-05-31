import 'package:flutter_template/packages/core/types/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()

/// Represents an application user
class User {
  final int id;
  final String email;
  final String name;
  final String profilePicture;
  final String? token;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.profilePicture,
    this.token,
  });

  factory User.fromJson(JSON json) => _$UserFromJson(json);
  JSON toJson() => _$UserToJson(this);
}
