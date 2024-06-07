import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/common/entities/user.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/features/profile/domain/repositories/profile_repository.dart';

class GetCurrentUserProfileData implements Usecase<User, NoParams> {
  final ProfileRepository profileRepository;
  GetCurrentUserProfileData(this.profileRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await profileRepository.getCurrentUserProfileData();
  }
}
