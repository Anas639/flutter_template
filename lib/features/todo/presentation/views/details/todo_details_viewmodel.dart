import 'package:collection/collection.dart';
import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';

class TodoDetailsViewmodel extends FlViewModel<Todo> {
  final _store = serviceLocator.get<TodosStore>();
  final String id;

  TodoDetailsViewmodel({
    required this.id,
  });

  @override
  void buildDependencies() {
    final todo = _store.todos.firstWhereOrNull((t) => t.id == id);
    setData(todo);
  }

  void handleCompletedCheckboxChanged(
    Todo todo, {
    bool value = false,
  }) {
    _store.update(
      id: todo.id,
      todo: todo.copyWith(
        completed: value,
      ),
    );

    serviceLocator.get<TodoRepository>().markAsCompleted(
          id: todo.id,
          value: value,
        );
  }

  void handleTitleChanged(String title) {
    if (title.trim().isEmpty) return;
    var todo = value;
    if (todo == null) return;

    _store.update(
      id: todo.id,
      todo: todo.copyWith(
        title: title,
      ),
    );
    serviceLocator.get<TodoRepository>().updateTitle(id: todo.id, title: title);
  }

  void handleDescriptionChanged(String description) {
    var todo = value;
    if (todo == null) return;

    _store.update(
      id: todo.id,
      todo: todo.copyWith(
        description: description,
      ),
    );
    serviceLocator.get<TodoRepository>().updateDescription(id: todo.id, description: description);
  }
}
