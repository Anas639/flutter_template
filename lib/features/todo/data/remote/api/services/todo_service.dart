import 'package:dio/dio.dart';
import 'package:flutter_template/features/todo/data/dto/new_todo.dart';
import 'package:flutter_template/features/todo/data/dto/update_todo.dart';
import 'package:flutter_template/features/todo/data/remote/api/response/todo_response.dart';
import 'package:flutter_template/features/todo/data/remote/api/response/todos_response.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:retrofit/retrofit.dart';

part 'todo_service.g.dart';

@RestApi(baseUrl: 'todos')
abstract class TodoService {
  factory TodoService(Dio dio, {String? baseUrl}) = _TodoService;

  @GET('')
  Future<TodosResponse> listAll();

  @PUT('/{id}')
  Future<TodoResponse> update(@Path('id') String id, @Body() UpdateTodoDto update);

  @POST('/add')
  Future<TodoResponse> create(@Body() NewTodoDto todo);

  @DELETE('/{id}')
  Future<BaseApiResponse> delete(@Path('id') String id);
}
