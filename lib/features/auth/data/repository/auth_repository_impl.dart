import 'package:flutter_template/features/auth/data/api/services/auth_service.dart';
import 'package:flutter_template/features/auth/data/dto/login_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_template/features/auth/data/mappers/user_mapper.dart';
import 'package:flutter_template/features/auth/domain/entities/user.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_template/packages/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.service,
  });

  final AuthService service;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await service.login(
        LoginDto(
          email: email,
          password: password,
        ),
      );

      if (!response.success || response.data == null) {
        return Left(RemoteFaliure(message: response.message ?? 'login_failed'));
      }
      return Right(UserMapper().toDomain(response.data!));
    } on Failure catch (f) {
      return Left(f);
    } catch (_) {
      return Left(Failure(message: 'login_failed'));
    }
  }
}
