import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/exceptions.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/network/connection_checker.dart';
import 'package:semaphore/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:semaphore/features/profile/data/models/profile_model.dart';
import 'package:semaphore/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final ConnectionChecker connectionChecker;

  ProfileRepositoryImpl(this.remoteDatasource, this.connectionChecker);

  @override
  Future<Either<Failure, ProfileModel>> getCurrentUserProfileData() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDatasource.currentSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }

        // To implement saving profiles locally and fetching from local datasource.
        return right(
          ProfileModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: session.user.userMetadata!['name'] ?? '',
          ),
        );
      }
      final profile = await remoteDatasource.getCurrentUserProfileData();
      if (profile == null) {
        return left(Failure('User not logged in'));
      }
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
