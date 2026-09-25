import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'form_status.dart';

part 'otp_cubit.freezed.dart';

@freezed
abstract class OtpState with _$OtpState {
  const factory OtpState({
    @Default('') String code,
    @Default(28) int secondsLeft,
    @Default(FormStatus.idle) FormStatus status,
    String? error,
  }) = _OtpState;

  const OtpState._();

  bool get complete => code.length == 6;
}

@injectable
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._verify, this._resend) : super(const OtpState()) {
    _startTimer();
  }

  final VerifyOtp _verify;
  final ResendOtp _resend;
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

  void codeChanged(String v) {
    final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
    emit(
      state.copyWith(
        code: digits.length > 6 ? digits.substring(0, 6) : digits,
        error: null,
      ),
    );
  }

  Future<void> resend() async {
    await _resend(const NoParams());
    emit(state.copyWith(secondsLeft: 28));
    _startTimer();
  }

  Future<void> verify() async {
    emit(state.copyWith(status: FormStatus.submitting));
    final res = await _verify(state.code);
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
