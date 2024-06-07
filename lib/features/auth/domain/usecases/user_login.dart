import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/core/common/entities/user.dart';
import 'package:semaphore/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
