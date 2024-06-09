import 'package:flutter/foundation.dart';
import 'package:semaphore/core/constants/supabase_constants.dart';
import 'package:semaphore/core/error/exceptions.dart';
import 'package:semaphore/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDatasource {
  Session? get currentSession;

  Future<ProfileModel?> getCurrentUserProfileData();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDatasourceImpl(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel?> getCurrentUserProfileData() async {
    try {
      if (currentSession != null) {
        final profileData = await supabaseClient
            .from(SupabaseConstants.profilesTableName)
            .select()
            .eq('id', currentSession!.user.id);

        return ProfileModel.fromJson(profileData.first)
            .copyWith(email: currentSession!.user.email);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      throw const ServerException(
          'Something went wrong. We\'re checking the issue.');
    }
  }
}
