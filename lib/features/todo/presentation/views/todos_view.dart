import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/todos_viewmodel.dart';
import 'package:flutter_template/features/todo/presentation/widgets/todo_list_item_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/todo_list_item.dart';

class TodosView extends FlView<TodosViewmodel> {
  const TodosView({super.key});

  @override
  TodosViewmodel? createViewModel() {
    return TodosViewmodel();
  }

  @override
  Widget? buildContainer(BuildContext context, Widget child, TodosViewmodel viewModel) {
    return RefreshIndicator(onRefresh: viewModel.onRefresh, child: child);
  }

  @override
  Widget buildEmptyState(BuildContext context, TodosViewmodel viewModel) {
    return Center(
      child: Text(viewModel.emptyMessage ?? ''),
    );
  }

  @override
  Widget buildLoadingState(BuildContext context, TodosViewmodel viewModel) {
    return Skeletonizer(
      enabled: true,
      ignoreContainers: false,
      effect: PulseEffect(
        duration: const Duration(
          seconds: 1,
          milliseconds: 500,
        ),
        to: Theme.of(context).colorScheme.onSurface,
        from: Theme.of(context).colorScheme.surface,
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (_, __) {
          return TodoListItemSkeleton();
        },
        itemCount: 3,
      ),
    );
  }

  @override
  Widget buildDataState(BuildContext context, TodosViewmodel viewModel) {
    final todos = viewModel.value ?? [];
    return ListView.separated(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          onCheckChanged: (value) {
            viewModel.onCheckChanged(todo, value ?? false);
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 12,
        );
      },
    );
  }
}
