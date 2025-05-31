import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/utils/string_utils.dart';

class AddTodoViewmodel extends FlViewModel {
  final TextEditingController textController = TextEditingController();

  final TodoRepository _todoRepository = serviceLocator.get<TodoRepository>();
  final TodosStore _todosStore = serviceLocator.get<TodosStore>();

  void onTodoSubmitted([String? text]) async {
    String title = text ?? textController.text.trim();
    if (title.isEmpty) return;

    textController.clear();

    String id = getRandomString(16);

    final todo = Todo.create(
      id: id,
      title: title,
      description: '',
    );
    _todosStore.add(todo);

    final response = await _todoRepository.create(
      title: title,
      description: '',
    );

    response.fold((l) {}, (r) {
      _todosStore.update(
        id: id,
        todo: r,
      );
    });
  }

  @override
  void onDispose() {
    textController.dispose();
    super.onDispose();
  }
}
