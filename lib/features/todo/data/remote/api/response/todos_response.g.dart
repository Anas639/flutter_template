// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosResponse _$TodosResponseFromJson(Map<String, dynamic> json) =>
    TodosResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodosResponseToJson(TodosResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
