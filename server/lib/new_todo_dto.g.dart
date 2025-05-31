// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_todo_dto.dart';

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
