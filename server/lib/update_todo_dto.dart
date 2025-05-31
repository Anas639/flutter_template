import 'package:json_annotation/json_annotation.dart';
import 'package:server/types.dart';

part 'update_todo_dto.g.dart';

@JsonSerializable(
  createToJson: false,
)
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
}
