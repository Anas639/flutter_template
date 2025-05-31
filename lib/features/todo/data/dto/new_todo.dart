import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_todo.g.dart';

@JsonSerializable()
class NewTodoDto {
  final String title;
  final String? description;
  final DateTime? dueDate;

  const NewTodoDto({
    required this.title,
    this.description,
    this.dueDate,
  });

  factory NewTodoDto.fromJson(JSON json) => _$NewTodoDtoFromJson(json);
  JSON toJson() => _$NewTodoDtoToJson(this);
}
