import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/details/todo_details_viewmodel.dart';

class TodoDetailsView extends FlView<TodoDetailsViewmodel> {
  const TodoDetailsView({
    super.key,
    required this.id,
  });

  final String id;
  @override
  TodoDetailsViewmodel? createViewModel() {
    return TodoDetailsViewmodel(id: id);
  }

  @override
  Widget? buildContainer(BuildContext context, Widget child, TodoDetailsViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildDataState(BuildContext context, TodoDetailsViewmodel viewModel) {
    var todo = viewModel.value;
    if (todo == null) return buildEmptyState(context, viewModel);
    return Column(
      children: [
        Hero(
          tag: 'todo-title-${todo.id}',
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  onSubmitted: viewModel.handleTitleChanged,
                  decoration: InputDecoration(
                    hintText: "Give this task a name 😠",
                    prefixIcon: const Icon(
                      Icons.edit,
                    ),
                    enabledBorder: InputBorder.none,
                  ),
                  controller: TextEditingController(text: todo.title),
                  maxLines: null,
                  minLines: 1,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Checkbox(
                value: todo.completed,
                onChanged: (value) {
                  viewModel.handleCompletedCheckboxChanged(
                    todo,
                    value: value ?? false,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              controller: TextEditingController(
                text: todo.description,
              ),
              onSubmitted: viewModel.handleDescriptionChanged,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Describe your task",
                prefixIcon: const Icon(
                  Icons.edit_note_rounded,
                ),
                enabledBorder: InputBorder.none,
              ),
              maxLines: null,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
