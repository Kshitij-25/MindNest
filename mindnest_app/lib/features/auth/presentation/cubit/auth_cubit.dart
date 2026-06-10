import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

import '../../domain/usecases/auth_usecases.dart';

class AuthState extends Equatable {
  const AuthState({this.submitting = false, this.failure});
  final bool submitting;
  final Failure? failure;

  AuthState copyWith({bool? submitting, Failure? failure}) =>
      AuthState(submitting: submitting ?? this.submitting, failure: failure);

  @override
  List<Object?> get props => [submitting, failure];
}

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signIn,
    this._signUp,
    this._verifyOtp,
    this._requestReset,
    this._session,
  ) : super(const AuthState());

  final SignIn _signIn;
  final SignUp _signUp;
  final VerifyOtp _verifyOtp;
  final RequestPasswordReset _requestReset;
  final SessionService _session;

  // The real tokens were already stored by AuthRemoteDataSource on a
  // successful sign-in/up. Only record the role here — do NOT call
  // _session.start(), which would clobber the issued access token.
  void _setRole(UserRole role) => _session.role = role.wire;

  /// Returns true on success so the page can navigate.
  Future<bool> signIn(
    UserRole role, {
    String email = '',
    String password = '',
  }) async {
    emit(state.copyWith(submitting: true));
    final result = await _signIn(
      SignInParams(email: email, password: password),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, failure: failure));
        return false;
      },
      (_) {
        _setRole(role);
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }

  Future<bool> signUp(
    UserRole role, {
    String name = '',
    String email = '',
    String password = '',
  }) async {
    emit(state.copyWith(submitting: true));
    final result = await _signUp(
      SignUpParams(name: name, email: email, password: password),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, failure: failure));
        return false;
      },
      (_) {
        _setRole(role);
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }

  Future<bool> verify(UserRole role, {String code = ''}) async {
    emit(state.copyWith(submitting: true));
    final result = await _verifyOtp(code);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, failure: failure));
        return false;
      },
      (_) {
        _setRole(role);
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }

  Future<bool> sendReset(String email) async {
    emit(state.copyWith(submitting: true));
    final result = await _requestReset(email);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, failure: failure));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }
}
