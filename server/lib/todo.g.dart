// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TodoCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Todo(...).copyWith(id: 12, name: "My name")
  /// ````
  Todo call({
    String id,
    String title,
    String description,
    bool completed,
    DateTime? dueDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTodo.copyWith(...)`.
class _$TodoCWProxyImpl implements _$TodoCWProxy {
  const _$TodoCWProxyImpl(this._value);

  final Todo _value;

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// Todo(...).copyWith(id: 12, name: "My name")
  /// ````
  Todo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? dueDate = const $CopyWithPlaceholder(),
  }) {
    return Todo(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      completed: completed == const $CopyWithPlaceholder()
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      dueDate: dueDate == const $CopyWithPlaceholder()
          ? _value.dueDate
          // ignore: cast_nullable_to_non_nullable
          : dueDate as DateTime?,
    );
  }
}

extension $TodoCopyWith on Todo {
  /// Returns a callable class that can be used as follows: `instanceOfTodo.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$TodoCWProxy get copyWith => _$TodoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed': instance.completed,
      'dueDate': instance.dueDate?.toIso8601String(),
    };
