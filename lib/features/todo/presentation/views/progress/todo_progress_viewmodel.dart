import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter_template/features/todo/domain/values/todo_progress.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/di/service_locator.dart';

class TodoProgressViewModel extends FlViewModel<TodoProgress> {
  @override
  void buildDependencies() {
    var todos = serviceLocator.get<TodosStore>().todos;

    int completeCount = todos.where((element) => element.completed).length;
    int inCompleteCount = todos.length - completeCount;

    setData(TodoProgress(completed: completeCount, inCompleted: inCompleteCount));
  }
}
