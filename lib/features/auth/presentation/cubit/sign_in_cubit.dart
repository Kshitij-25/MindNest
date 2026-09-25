import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'form_status.dart';

part 'sign_in_cubit.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool obscure,
    @Default(FormStatus.idle) FormStatus status,
    String? error,
    AppUser? user,
  }) = _SignInState;
}

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signIn, this._social) : super(const SignInState());

  final SignIn _signIn;
  final SocialSignIn _social;

  void emailChanged(String v) => emit(state.copyWith(email: v, error: null));
  void passwordChanged(String v) =>
      emit(state.copyWith(password: v, error: null));
  void toggleObscure() => emit(state.copyWith(obscure: !state.obscure));

  Future<void> submit(UserRole role) async {
    emit(state.copyWith(status: FormStatus.submitting, error: null));
    final res = await _signIn(
      SignInParams(email: state.email, password: state.password, role: role),
    );
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (u) => emit(state.copyWith(status: FormStatus.success, user: u)),
    );
  }

  Future<void> social(String provider, UserRole role) async {
    emit(state.copyWith(status: FormStatus.submitting, error: null));
    final res = await _social(SocialSignInParams(provider, role));
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (u) => emit(state.copyWith(status: FormStatus.success, user: u)),
    );
  }
}
