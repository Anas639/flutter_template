import 'package:dio/dio.dart';
import 'package:flutter_template/features/todo/data/remote/api/services/todo_service.dart';
import 'package:flutter_template/features/todo/data/repository/todo_repository_impl.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';

Future<void> registerTodoDependencies({
  required Dio dio,
}) async {
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      remote: TodoService(dio),
    ),
  );
  serviceLocator.registerSingleton<TodosStore>(TodosStore());
}
