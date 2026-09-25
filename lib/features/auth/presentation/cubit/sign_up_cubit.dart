import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'form_status.dart';

part 'sign_up_cubit.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool agreed,
    @Default(FormStatus.idle) FormStatus status,
    String? error,
    AppUser? user,
  }) = _SignUpState;

  const SignUpState._();

  bool get valid =>
      name.trim().isNotEmpty &&
      email.contains('@') &&
      password.length >= 6 &&
      agreed;

  /// 0..3 (Too short, Weak, Good, Strong) — mirrors the prototype.
  int get strength {
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final s = password.length ~/ 3 + (hasDigit ? 1 : 0);
    return s > 3 ? 3 : s;
  }
}

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUp) : super(const SignUpState());

  final SignUp _signUp;

  void nameChanged(String v) => emit(state.copyWith(name: v, error: null));
  void emailChanged(String v) => emit(state.copyWith(email: v, error: null));
  void passwordChanged(String v) =>
      emit(state.copyWith(password: v, error: null));
  void toggleAgreed() => emit(state.copyWith(agreed: !state.agreed));

  Future<void> submit(UserRole role) async {
    if (!state.valid) return;
    emit(state.copyWith(status: FormStatus.submitting));
    final res = await _signUp(
      SignUpParams(
        name: state.name,
        email: state.email,
        password: state.password,
        role: role,
      ),
    );
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (u) => emit(state.copyWith(status: FormStatus.success, user: u)),
    );
  }
}
