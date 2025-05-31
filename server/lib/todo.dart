import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:server/dto.dart';
import 'package:server/types.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@JsonSerializable()
@CopyWith(skipFields: true)
class Todo implements ApiResponseData {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime? dueDate;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.dueDate,
  });

  factory Todo.fromJson(JSON json) => _$TodoFromJson(json);

  factory Todo.create({
    required String title,
    required String description,
    DateTime? dueDate,
  }) =>
      Todo(
        id: Uuid().v4().replaceAll('-', ''),
        title: title,
        description: description,
        completed: false,
        dueDate: dueDate,
      );

  @override
  JSON toJson() => _$TodoToJson(this);
}
