import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:server/api_response.dart';
import 'package:server/json_extension.dart';
import 'package:server/jwt.dart';
import 'package:server/login_dto.dart';
import 'package:server/new_todo_dto.dart';
import 'package:server/todo.dart';
import 'package:server/update_todo_dto.dart';
import 'package:server/user_dto.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

var users = <UserDto>[
  UserDto(
    id: 1,
    name: 'Moul Ndader',
    email: 'moul.ndader@gmail.com',
    password: 'ndader123',
    profilePicture: 'https://i.pravatar.cc/400?img=50',
  ),
  UserDto(
      id: 2,
      name: 'Lmbawaq',
      email: 'pablo.king@gmail.com',
      password: 'plataoplomo',
      profilePicture: 'https://i.pravatar.cc/400?img=6'),
];

var todos = <int, List<Todo>>{};

void main(List<String> arguments) {
  int port = int.parse(
    String.fromEnvironment(
      'PORT',
      defaultValue: '8080',
    ),
  );

  var app = shelf_router.Router();

  app.get(
      '/todos',
      Pipeline().addMiddleware(authorize()).addHandler((Request request) {
        final user = request.context['user'] as UserDto?;
        if (user == null) return Response(401);
        final userTodos = todos[user.id];

        return Response.ok(
          ApiResponse<List<Todo>>(
            data: userTodos ?? [],
            success: true,
          ).encodeJSON(),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }));

  app.get(
      '/todos/<id>',
      Pipeline().addMiddleware(authorize()).addHandler((Request request) {
        final user = request.context['user'] as UserDto?;
        if (user == null) return Response(401);

        String todoId = request.params['id'] ?? '';

        final userTodos = todos[user.id] ?? [];

        final todo = userTodos.firstWhereOrNull((t) => t.id == todoId);
        if (todo == null) {
          return Response.notFound(
            ApiResponse(
              success: false,
              message: "item not found",
            ).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        }
        return Response.ok(
          todo.encodeJSON(),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }));

  app.post(
      '/todos/add',
      Pipeline().addMiddleware(authorize()).addHandler((Request request) async {
        try {
          final user = request.context['user'] as UserDto?;
          if (user == null) return Response(401);

          final json = jsonDecode(await request.readAsString());
          final newTodo = NewTodoDto.fromJson(json);
          final todo = Todo.create(
            title: newTodo.title,
            description: newTodo.description ?? '',
            dueDate: newTodo.dueDate,
          );
          final userTodos = todos[user.id] ?? [];
          userTodos.add(todo);
          todos[user.id] = userTodos;
          return Response.ok(
            ApiResponse<Todo>(
              success: true,
              data: todo,
            ).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        } catch (_) {
          return Response.badRequest(
            body: ApiResponse(success: false).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        }
      }));

  app.put(
      '/todos/<id>',
      Pipeline().addMiddleware(authorize()).addHandler((Request request) async {
        try {
          final user = request.context['user'] as UserDto?;
          if (user == null) return Response(401);
          final String todoId = request.params['id'] ?? '';
          final userTodos = todos[user.id] ?? [];
          final todoIndex = userTodos.indexWhere((t) => t.id == todoId);
          if (todoIndex < 0) {
            return Response.notFound(
              ApiResponse(
                success: false,
                message: "item not found",
              ).encodeJSON(),
              headers: {
                'Content-Type': 'application/json',
              },
            );
          }
          final todo = userTodos[todoIndex];
          final json = jsonDecode(await request.readAsString());
          final updateTodo = UpdateTodoDto.fromJson(json);

          userTodos[todoIndex] = todo.copyWith(
            title: updateTodo.title ?? todo.title,
            description: updateTodo.description ?? todo.description,
            completed: updateTodo.completed ?? todo.completed,
            dueDate: updateTodo.dueDate ?? todo.dueDate,
          );
          todos[user.id] = userTodos;

          return Response.ok(
            ApiResponse<Todo>(
              success: true,
              data: userTodos[todoIndex],
            ).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        } catch (e) {
          print(e.toString());
          return Response.badRequest(
            body: ApiResponse(success: false).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        }
      }));

  app.delete(
      '/todos/<id>',
      Pipeline().addMiddleware(authorize()).addHandler((Request request) {
        final user = request.context['user'] as UserDto?;
        if (user == null) return Response(401);
        final userTodos = todos[user.id] ?? [];
        String todoId = request.params['id'] ?? '';
        final todoIndex = userTodos.indexWhere((t) => t.id == todoId);
        if (todoIndex < 0) {
          return Response.notFound(
            ApiResponse(
              success: false,
              message: "item not found",
            ).encodeJSON(),
            headers: {
              'Content-Type': 'application/json',
            },
          );
        }

        userTodos.removeAt(todoIndex);
        todos[user.id] = userTodos;

        return Response.ok(
          ApiResponse(
            message: 'item deleted',
            success: true,
          ).encodeJSON(),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }));

  app.post('/login', (Request request) async {
    try {
      final json = jsonDecode(await request.readAsString());
      final login = LoginDto.fromJson(json);
      final user = users.firstWhereOrNull((u) => u.login(login));
      if (user == null) {
        return Response.unauthorized(ApiResponse(
          success: false,
          message: 'Who are you ? 🤨',
        ).encodeJSON());
      }

      final jwt = createUserJWT(user.id.toString());

      return Response.ok(
          ApiResponse(
            success: true,
            message: 'welcome',
            data: user.copyWith(token: jwt),
          ).encodeJSON(),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return Response.badRequest(body: ApiResponse(success: false, message: e.toString()).encodeJSON());
    }
  });

  shelf_io.serve(app.call, InternetAddress.anyIPv4, port);
}

extension on UserDto {
  bool login(LoginDto login) {
    return email == login.email && password == login.password;
  }
}

Middleware authorize() {
  return (innerHandler) {
    return (request) {
      final authorizationHeader = request.headers['Authorization'] ?? request.headers['authorization'];

      if (authorizationHeader == null) {
        return Response(401);
      }

      if (!authorizationHeader.startsWith('Bearer ')) {
        return Response(401);
      }

      final token = authorizationHeader.replaceFirst('Bearer', '').trim();

      if (token.isEmpty) {
        return Response(401);
      }

      final jwt = verifyJWT(token);

      if (jwt == null) {
        return Response(401);
      }

      final user = users.firstWhereOrNull((u) => u.id.toString() == jwt.payload['id']?.toString());

      if (user == null) {
        return Response(401);
      }

      request = request.change(context: {'user': user});

      return Future.sync(() => innerHandler(request)).then((response) {
        return response;
      });
    };
  };
}
