// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTodoDto _$NewTodoDtoFromJson(Map<String, dynamic> json) => NewTodoDto(
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$NewTodoDtoToJson(NewTodoDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
    };
