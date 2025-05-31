// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDto _$TodoDtoFromJson(Map<String, dynamic> json) => TodoDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$TodoDtoToJson(TodoDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed': instance.completed,
      'dueDate': instance.dueDate?.toIso8601String(),
    };
