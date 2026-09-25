import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/usecases/auth_usecases.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/profile_details.dart';
import '../../domain/usecases/profile_usecases.dart';

part 'edit_profile_cubit.freezed.dart';

@freezed
abstract class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String bio,
    @Default(false) bool loaded,
    @Default(false) bool saving,
    @Default(false) bool saved,
    String? error,
  }) = _EditProfileState;

  const EditProfileState._();

  bool get valid => name.trim().isNotEmpty && email.contains('@');
}

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._auth, this._get, this._save, this._updateUser) : super(const EditProfileState());

  final AuthBloc _auth;
  final GetProfileDetails _get;
  final SaveProfileDetails _save;
  final UpdateUser _updateUser;

  Future<void> load() async {
    final u = _auth.state.user;
    final d = (await _get(const NoParams())).getOrElse((_) => const ProfileDetails());
    emit(EditProfileState(name: u?.name ?? '', email: u?.email ?? '', phone: d.phone, bio: d.bio, loaded: true));
  }

  void nameChanged(String v) => emit(state.copyWith(name: v));
  void emailChanged(String v) => emit(state.copyWith(email: v));
  void phoneChanged(String v) => emit(state.copyWith(phone: v));
  void bioChanged(String v) => emit(state.copyWith(bio: v));

  Future<void> save() async {
    final u = _auth.state.user;
    if (u == null || !state.valid) return;
    emit(state.copyWith(saving: true));
    await _save(ProfileDetails(phone: state.phone.trim(), bio: state.bio.trim()));
    final res = await _updateUser(u.copyWith(name: state.name.trim(), email: state.email.trim()));
    res.fold(
      (f) => emit(state.copyWith(saving: false, error: f.message)),
      (nu) {
        _auth.add(AuthEvent.userChanged(nu));
        emit(state.copyWith(saving: false, saved: true));
      },
    );
  }
}
