import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'todo.g.dart';

@CopyWith(
  skipFields: true,
)
class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime? dueDate;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.dueDate,
  });

  factory Todo.create({
    String? id,
    required String title,
    required String description,
    DateTime? dueDate,
  }) =>
      Todo(
        id: id ?? '',
        title: title,
        description: description,
        dueDate: dueDate,
        completed: false,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        completed,
      ];
}
