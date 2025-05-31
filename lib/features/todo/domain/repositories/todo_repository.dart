import 'package:dartz/dartz.dart';
import 'package:flutter_template/packages/core/core.dart';

import '../entities/todo.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, List<Todo>>> listAll();
  Future<Either<Failure, Todo>> markAsCompleted({required String id, required bool value});
  Future<Either<Failure, Todo>> updateTitle({
    required String id,
    required String title,
  });
  Future<Either<Failure, Todo>> updateDescription({
    required String id,
    required String description,
  });
  Future<Either<Failure, Todo>> create({
    required String title,
    required String description,
    DateTime? dueDate,
  });
  Future<Either<Failure, void>> delete(String id);
}
