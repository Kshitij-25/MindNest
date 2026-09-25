import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/app_user.dart';
import '../entities/user_role.dart';
import '../repositories/auth_repository.dart';

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
    required this.role,
  });
  final String email;
  final String password;
  final UserRole role;

  @override
  List<Object?> get props => [email, password, role];
}

@injectable
class SignIn implements UseCase<AppUser, SignInParams> {
  const SignIn(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<AppUser> call(SignInParams p) =>
      _repo.signIn(email: p.email.trim(), password: p.password, role: p.role);
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
  final String name;
  final String email;
  final String password;
  final UserRole role;

  @override
  List<Object?> get props => [name, email, password, role];
}

@injectable
class SignUp implements UseCase<AppUser, SignUpParams> {
  const SignUp(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<AppUser> call(SignUpParams p) async {
    if (p.name.trim().isEmpty) {
      return const Left(ValidationFailure('Please enter your name.'));
    }
    if (!p.email.contains('@')) {
      return const Left(ValidationFailure('Please enter a valid email.'));
    }
    if (p.password.length < 6) {
      return const Left(ValidationFailure('Use at least 6 characters.'));
    }
    return _repo.signUp(
      name: p.name.trim(),
      email: p.email.trim(),
      password: p.password,
      role: p.role,
    );
  }
}

class SocialSignInParams extends Equatable {
  const SocialSignInParams(this.provider, this.role);
  final String provider;
  final UserRole role;

  @override
  List<Object?> get props => [provider, role];
}

@injectable
class SocialSignIn implements UseCase<AppUser, SocialSignInParams> {
  const SocialSignIn(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<AppUser> call(SocialSignInParams p) =>
      _repo.socialSignIn(provider: p.provider, role: p.role);
}

@injectable
class SendPasswordReset implements UseCase<void, String> {
  const SendPasswordReset(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(String email) async {
    if (!email.contains('@')) {
      return const Left(ValidationFailure('Please enter a valid email.'));
    }
    return _repo.sendPasswordReset(email.trim());
  }
}

/// Confirms the user has clicked the link in their verification email.
@injectable
class CheckEmailVerified implements UseCase<void, NoParams> {
  const CheckEmailVerified(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(NoParams _) => _repo.checkEmailVerified();
}

@injectable
class ResendVerificationEmail implements UseCase<void, NoParams> {
  const ResendVerificationEmail(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(NoParams _) => _repo.resendVerificationEmail();
}

@injectable
class UpdateUser implements UseCase<AppUser, AppUser> {
  const UpdateUser(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<AppUser> call(AppUser user) => _repo.updateUser(user);
}

@injectable
class SignOut implements UseCase<void, NoParams> {
  const SignOut(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(NoParams _) => _repo.signOut();
}
