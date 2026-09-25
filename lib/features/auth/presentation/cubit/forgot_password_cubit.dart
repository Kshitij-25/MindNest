import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/auth_usecases.dart';
import 'form_status.dart';

part 'forgot_password_cubit.freezed.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(FormStatus.idle) FormStatus status,
    String? error,
  }) = _ForgotPasswordState;
}

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._send) : super(const ForgotPasswordState());
  final SendPasswordReset _send;

  void emailChanged(String v) => emit(state.copyWith(email: v, error: null));

  Future<void> submit() async {
    emit(state.copyWith(status: FormStatus.submitting));
    final res = await _send(state.email);
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (_) => emit(state.copyWith(status: FormStatus.success)),
    );
  }

  void reset() => emit(state.copyWith(status: FormStatus.idle));
}
