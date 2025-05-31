import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/delete/todo_delete_view.dart';
import 'package:flutter_template/features/todo/presentation/views/details/todo_details_view.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          TodoDeleteView(id: id),
        ],
      ),
      body: TodoDetailsView(
        id: id,
      ),
    );
  }
}
