import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/constants/constants.dart';
import 'package:semaphore/core/error/exceptions.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/network/connection_checker.dart';
import 'package:semaphore/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:semaphore/features/auth/data/models/user_model.dart';
import 'package:semaphore/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Depending on the interface instead of the implementation,
  // will be helpful when implementation is prone to change in the future.
  final AuthRemoteDatasource remoteDatasource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.remoteDatasource, this.connectionChecker);

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserModel>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signupWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      return right(await remoteDatasource.logout());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, UserModel>> _getUser(
    Future<UserModel> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
