import 'package:flutter_template/features/todo/data/dto/new_todo.dart';
import 'package:flutter_template/features/todo/data/dto/update_todo.dart';
import 'package:flutter_template/features/todo/data/mappers/todo_mapper.dart';
import 'package:flutter_template/features/todo/data/remote/api/services/todo_service.dart';
import 'package:flutter_template/features/todo/domain/entities/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_template/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_template/packages/core/core.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl({
    required this.remote,
  });

  final TodoService remote;

  @override
  Future<Either<Failure, List<Todo>>> listAll() async {
    try {
      final response = await remote.listAll();

      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'list_todo_failed'));
      }

      final todos = response.data ?? [];
      final mapper = TodoMapper();
      return Right(todos.map(mapper.toDomain).toList());
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> markAsCompleted({required String id, required bool value}) async {
    try {
      final response = await remote.update(
        id,
        UpdateTodoDto(
          completed: value,
        ),
      );

      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final todo = response.data;
      if (todo == null) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final mapper = TodoMapper();
      return Right(mapper.toDomain(todo));
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTitle({required String id, required String title}) async {
    try {
      final response = await remote.update(
        id,
        UpdateTodoDto(
          title: title,
        ),
      );
      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final todo = response.data;
      if (todo == null) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final mapper = TodoMapper();
      return Right(mapper.toDomain(todo));
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateDescription({required String id, required String description}) async {
    try {
      final response = await remote.update(
        id,
        UpdateTodoDto(
          description: description,
        ),
      );

      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final todo = response.data;
      if (todo == null) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_update_failure'));
      }

      final mapper = TodoMapper();
      return Right(mapper.toDomain(todo));
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> create({
    required String title,
    required String description,
    DateTime? dueDate,
  }) async {
    try {
      final response = await remote.create(
        NewTodoDto(
          title: title,
          description: description,
          dueDate: dueDate,
        ),
      );

      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_creation_failure'));
      }

      final newTodo = response.data;
      if (newTodo == null) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_creation_failure'));
      }

      final mapper = TodoMapper();
      return Right(mapper.toDomain(newTodo));
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      final response = await remote.delete(id);
      if (!response.success) {
        return Left(RemoteFaliure(message: response.message ?? 'todo_remove_failure'));
      }
      return Right(null);
    } on Failure catch (f, s) {
      AppLogger.error(s.toString());
      AppLogger.error(f.message);
      return Left(f);
    } catch (e, s) {
      AppLogger.error(s.toString());
      AppLogger.error(e.toString());
      return Left(RemoteFaliure(message: e.toString()));
    }
  }
}
