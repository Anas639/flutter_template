import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/add/add_todo_viewmodel.dart';

class AddTodoView extends FlView<AddTodoViewmodel> {
  const AddTodoView({super.key});

  @override
  AddTodoViewmodel? createViewModel() {
    return AddTodoViewmodel();
  }

  @override
  Widget buildEmptyState(BuildContext context, AddTodoViewmodel viewModel) {
    return buildDataState(context, viewModel);
  }

  @override
  Widget buildDataState(BuildContext context, AddTodoViewmodel viewModel) {
    return SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: viewModel.onTodoSubmitted,
                controller: viewModel.textController,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind? 🧠',
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: IconButton(
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: viewModel.onTodoSubmitted,
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),);
  }
}
