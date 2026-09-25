import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecases.dart';

part 'auth_bloc.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = AuthStarted;
  const factory AuthEvent.roleSelected(UserRole role) = AuthRoleSelected;
  const factory AuthEvent.userChanged(AppUser user) = AuthUserChanged;
  const factory AuthEvent.onboardingCompleted() = AuthOnboardingCompleted;
  const factory AuthEvent.credentialsSubmitted() = AuthCredentialsSubmitted;
  const factory AuthEvent.signedOut() = AuthSignedOut;
}

enum AuthStatus { unknown, unauthenticated, authenticated }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    AppUser? user,
    @Default(UserRole.client) UserRole role,
  }) = _AuthState;

  const AuthState._();

  bool get isPro => (user?.role ?? role) == UserRole.professional;
}

/// Global session state: who is signed in and in which role.
@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo, this._updateUser, this._signOut)
    : super(const AuthState()) {
    on<AuthStarted>((e, emit) {
      final u = _repo.cachedUser;
      emit(
        u == null
            ? state.copyWith(status: AuthStatus.unauthenticated)
            : AuthState(
                status: AuthStatus.authenticated,
                user: u,
                role: u.role,
              ),
      );
    });
    on<AuthRoleSelected>((e, emit) => emit(state.copyWith(role: e.role)));
    on<AuthUserChanged>(
      (e, emit) => emit(
        AuthState(
          status: AuthStatus.authenticated,
          user: e.user,
          role: e.user.role,
        ),
      ),
    );
    on<AuthOnboardingCompleted>((e, emit) async {
      final u = state.user;
      if (u == null) return;
      final res = await _updateUser(u.copyWith(onboarded: true));
      res.fold((_) {}, (nu) => emit(state.copyWith(user: nu)));
    });
    on<AuthCredentialsSubmitted>((e, emit) async {
      final u = state.user;
      if (u == null) return;
      final res = await _updateUser(
        u.copyWith(verification: VerificationStatus.pending),
      );
      res.fold((_) {}, (nu) => emit(state.copyWith(user: nu)));
    });
    on<AuthSignedOut>((e, emit) async {
      await _signOut(const NoParams());
      emit(AuthState(status: AuthStatus.unauthenticated, role: state.role));
    });
  }

  final AuthRepository _repo;
  final UpdateUser _updateUser;
  final SignOut _signOut;
}
