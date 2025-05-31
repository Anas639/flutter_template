import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/add/add_todo_view.dart';
import 'package:flutter_template/features/todo/presentation/views/progress/todo_progress_view.dart';
import 'package:flutter_template/features/todo/presentation/views/todos_view.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 24,
          children: [
            AddTodoView(),
            TodoProgressView(),
            Expanded(
              child: TodosView(),
            ),
          ],
        ),
      ),
    );
  }
}
