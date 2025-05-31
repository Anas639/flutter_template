import 'package:flutter_template/features/todo/data/dto/todo_dto.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todos_response.g.dart';

@JsonSerializable()
class TodosResponse extends BaseApiResponse {
  final List<TodoDto>? data;

  const TodosResponse({
    required super.success,
    super.message,
    this.data,
  });

  factory TodosResponse.fromJson(JSON json) => _$TodosResponseFromJson(json);
  @override
  JSON toJson() => _$TodosResponseToJson(this);
}
