import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/screens/todo_details_screen.dart';
import 'package:flutter_template/features/todo/presentation/screens/todos_screen.dart';
import 'package:go_router/go_router.dart';

final class TodoRoutes {
  static final routes = [
    GoRoute(
      path: '/todos',
      builder: (context, state) {
        return const TodosScreen();
      },
    ),
    GoRoute(
      path: '/todos/:id',
      builder: (context, state) {
        String id = state.pathParameters['id'] ?? '';
        return TodoDetailsScreen(
          id: id,
        );
      },
    ),
  ];

  static Future openDetails(BuildContext context, String id) {
    return context.push('/todos/$id');
  }
}
