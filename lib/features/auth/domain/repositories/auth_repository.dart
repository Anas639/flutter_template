import 'package:dartz/dartz.dart';
import 'package:flutter_template/features/auth/domain/entities/user.dart';
import 'package:flutter_template/packages/core/core.dart';

abstract interface class AuthRepository {
  /// Attempt login with [email] and [password]
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
