import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'form_status.dart';

part 'otp_cubit.freezed.dart';

/// Email verification after sign-up: the user taps the link Firebase sent,
/// then confirms here.
@freezed
abstract class OtpState with _$OtpState {
  const factory OtpState({
    @Default(30) int secondsLeft,
    @Default(FormStatus.idle) FormStatus status,
    String? error,
  }) = _OtpState;
}

@injectable
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._check, this._resend) : super(const OtpState()) {
    _startTimer();
  }

  final CheckEmailVerified _check;
  final ResendVerificationEmail _resend;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state.secondsLeft <= 0) {
        t.cancel();
      } else {
        emit(state.copyWith(secondsLeft: state.secondsLeft - 1));
      }
    });
  }

  Future<void> resend() async {
    final res = await _resend(const NoParams());
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (_) => emit(state.copyWith(status: FormStatus.idle, secondsLeft: 30, error: null)),
    );
    _startTimer();
  }

  Future<void> verify() async {
    emit(state.copyWith(status: FormStatus.submitting, error: null));
    final res = await _check(const NoParams());
    res.fold(
      (f) => emit(state.copyWith(status: FormStatus.failure, error: f.message)),
      (_) => emit(state.copyWith(status: FormStatus.success)),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
