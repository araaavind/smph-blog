import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/core/common/entities/user.dart';
import 'package:semaphore/features/auth/domain/repositories/auth_repository.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signupWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
