import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:semaphore/core/common/entities/user.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/features/profile/domain/usecases/get_current_user_profile_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserProfileData _getCurrentUserProfileData;
  final AppUserCubit _appUserCubit;

  ProfileBloc(
      {required GetCurrentUserProfileData getCurrentUserProfileData,
      required AppUserCubit appUserCubit})
      : _getCurrentUserProfileData = getCurrentUserProfileData,
        _appUserCubit = appUserCubit,
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      final res = await _getCurrentUserProfileData(NoParams());

      res.fold(
        (failure) => emit(ProfileFailure(failure.message)),
        (profile) => _emitSuccess(profile, emit),
      );
    });
  }

  void _emitSuccess(User user, Emitter<ProfileState> emit) {
    _appUserCubit.updateUser(user);
    emit(ProfileSuccess(user));
  }
}
