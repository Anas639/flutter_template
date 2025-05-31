// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
      token: json['token'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      info: json['info'] as Map<String, dynamic>?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'info': instance.info,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
