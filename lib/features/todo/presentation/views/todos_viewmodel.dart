import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';

import '../../domain/entities/todo.dart';

class TodosViewmodel extends FlViewModel<List<Todo>> {
  final _store = serviceLocator.get<TodosStore>();
  @override
  void buildDependencies() {
    final todos = _store.todos;
    if (todos.isEmpty) {
      setEmpty('What\'s on your mind? 🧠');
      return;
    }
    setData(todos);
  }

  @override
  void onViewInitialized() {
    super.onViewInitialized();
    _fetchTodos();
  }

  void _fetchTodos({bool refresh = false}) async {
    final todos = value ?? [];
    if (todos.isNotEmpty && !refresh) {
      return;
    }
    setLoading();
    final response = await serviceLocator.get<TodoRepository>().listAll();
    response.fold((l) => setError(l.message), (r) => _store.replaceAll(r));
  }

  void onCheckChanged(Todo todo, bool value) {
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

  Future onRefresh() {
    _fetchTodos(
      refresh: true,
    );
    // ignore: invalid_use_of_visible_for_testing_member
    return waitForStateChange<FlDataState>();
  }
}
