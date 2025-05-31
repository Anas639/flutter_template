import 'package:collection/collection.dart';
import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';

class TodoDeleteViewmodel extends FlViewModel<Todo> {
  TodoDeleteViewmodel({
    required this.id,
  });

  final String id;

  final _store = serviceLocator.get<TodosStore>();

  @override
  void buildDependencies() {
    final todo = _store.todos.firstWhereOrNull((t) => t.id == id);
    setData(todo);
  }

  void handleDeleteTodoPressed() {
    var todo = value;
    if (todo == null) return;
    _store.delete(todo.id);
    serviceLocator.get<TodoRepository>().delete(todo.id);
  }
}
