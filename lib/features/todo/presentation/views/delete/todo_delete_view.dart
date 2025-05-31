import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/todo/presentation/views/delete/todo_delete_viewmodel.dart';
import 'package:flutter_template/packages/core/ui/dialogs/confirmation_dialog.dart';

class TodoDeleteView extends FlView<TodoDeleteViewmodel> {
  const TodoDeleteView({
    super.key,
    required this.id,
  });

  final String id;
  @override
  TodoDeleteViewmodel? createViewModel() {
    return TodoDeleteViewmodel(
      id: id,
    );
  }

  @override
  Widget buildDataState(BuildContext context, TodoDeleteViewmodel viewModel) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final todoName = viewModel.value?.title ?? '';
            return ConfirmationDialog(
              message: "Are you sure you want to permanently delete \"$todoName\"?",
              onConfirm: () {
                viewModel.handleDeleteTodoPressed();
                Navigator.pop(context);
              },
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.redAccent,
      ),
    );
  }
}
