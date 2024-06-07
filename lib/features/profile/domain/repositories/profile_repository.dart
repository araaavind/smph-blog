import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/common/entities/user.dart';
import 'package:semaphore/core/error/failures.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, User>> getCurrentUserProfileData();
}
