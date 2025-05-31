import 'package:flutter_template/features/todo/data/dto/todo_dto.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:flutter_template/packages/core/core.dart';

class TodoMapper implements DataMapper<Todo, TodoDto> {
  @override
  TodoDto toData(Todo domain) {
    return TodoDto(
      id: domain.id,
      title: domain.title,
      completed: domain.completed,
      description: domain.description,
      dueDate: domain.dueDate,
    );
  }

  @override
  Todo toDomain(TodoDto data) {
    return Todo(
      dueDate: data.dueDate,
      description: data.description,
      completed: data.completed,
      title: data.title,
      id: data.id,
    );
  }
}
