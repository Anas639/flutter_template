import 'package:flutter_template/features/todo/data/dto/todo_dto.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_response.g.dart';

@JsonSerializable()
class TodoResponse extends BaseApiResponse {
  final TodoDto? data;

  const TodoResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory TodoResponse.fromJson(JSON json) => _$TodoResponseFromJson(json);
  @override
  JSON toJson() => _$TodoResponseToJson(this);
}
