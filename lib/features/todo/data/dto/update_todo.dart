import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_todo.g.dart';

@JsonSerializable()
class UpdateTodoDto {
  final String? title;
  final String? description;
  final DateTime? dueDate;
  final bool? completed;

  const UpdateTodoDto({
    this.title,
    this.description,
    this.dueDate,
    this.completed,
  });
  factory UpdateTodoDto.fromJson(JSON json) => _$UpdateTodoDtoFromJson(json);
  JSON toJson() => _$UpdateTodoDtoToJson(this);
}
