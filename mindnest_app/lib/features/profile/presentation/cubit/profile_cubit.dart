import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/profile_usecases.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ViewStatus.initial,
    this.profile,
    this.failure,
  });
  final ViewStatus status;
  final UserProfile? profile;
  final Failure? failure;

  ProfileState copyWith({
    ViewStatus? status,
    UserProfile? profile,
    Failure? failure,
  }) => ProfileState(
    status: status ?? this.status,
    profile: profile ?? this.profile,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, profile, failure];
}

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile) : super(const ProfileState());
  final GetUserProfile _getProfile;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getProfile(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ViewStatus.error, failure: failure)),
      (profile) =>
          emit(state.copyWith(status: ViewStatus.loaded, profile: profile)),
    );
  }
}
