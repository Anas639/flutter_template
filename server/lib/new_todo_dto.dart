import 'package:json_annotation/json_annotation.dart';
import 'package:server/types.dart';

part 'new_todo_dto.g.dart';

@JsonSerializable(
  createToJson: false,
)
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
}
