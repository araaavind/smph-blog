import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}
