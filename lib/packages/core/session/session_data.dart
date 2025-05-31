import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_data.g.dart';

@JsonSerializable()
class SessionData {
  final String token;
  final String userId;
  final JSON? info;
  final DateTime createdAt;
  final DateTime? expiresAt;

  bool get isExpired => expiresAt?.isBefore(DateTime.now()) ?? false;

  const SessionData({
    required this.token,
    required this.userId,
    required this.createdAt,
    this.info,
    this.expiresAt,
  });

  SessionData.create({
    required this.token,
    required this.userId,
    this.info,
    this.expiresAt,
  }) : createdAt = DateTime.now();

  factory SessionData.fromJson(JSON json) => _$SessionDataFromJson(json);

  JSON toJson() => _$SessionDataToJson(this);
}
