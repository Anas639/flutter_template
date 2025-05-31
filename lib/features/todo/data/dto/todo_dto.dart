import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDto {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime? dueDate;

  const TodoDto({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.dueDate,
  });

  factory TodoDto.fromJson(JSON json) => _$TodoDtoFromJson(json);

  JSON toJson() => _$TodoDtoToJson(this);
}
