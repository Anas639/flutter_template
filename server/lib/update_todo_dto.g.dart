// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTodoDto _$UpdateTodoDtoFromJson(Map<String, dynamic> json) =>
    UpdateTodoDto(
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completed: json['completed'] as bool?,
    );
