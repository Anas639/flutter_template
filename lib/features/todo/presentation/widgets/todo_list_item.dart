import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:flutter_template/features/todo/presentation/routes/routes.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onCheckChanged,
  });

  final Todo todo;
  final ValueChanged<bool?> onCheckChanged;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'todo-title-${todo.id}',
      child: ListTile(
        title: Text(todo.title),
        onTap: () {
          TodoRoutes.openDetails(context, todo.id);
        },
        subtitle: todo.description.isEmpty
            ? null
            : Text(
                todo.description,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
        trailing: Checkbox(
          onChanged: onCheckChanged,
          value: todo.completed,
        ),
      ),
    );
  }
}
