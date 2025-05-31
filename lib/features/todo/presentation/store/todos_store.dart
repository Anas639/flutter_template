import 'package:fl_mvvm/fl_mvvm.dart';

import '../../domain/entities/todo.dart';

class TodosStore {
  final _todos = listSignal<Todo>([]);

  List<Todo> get todos => _todos.value.toList();

  void replaceAll(List<Todo> todos) {
    _todos.value = todos;
  }

  void add(Todo todo) {
    _todos.value.add(todo);
  }

  void update({
    required String id,
    required Todo todo,
  }) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index < 0) return;
    _todos[index] = todo;
  }

  void delete(String id) {
    _todos.removeWhere((t) => t.id == id);
  }

  void clear() {
    _todos.clear();
  }
}
