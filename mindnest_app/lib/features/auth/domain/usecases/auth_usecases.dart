import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

/// Credentials for [SignIn].
class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Details for [SignUp].
class SignUpParams extends Equatable {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

@lazySingleton
class SignIn implements UseCase<Unit, SignInParams> {
  SignIn(this._repo);
  final AuthRepository _repo;
  @override
  Future<Result<Unit>> call(SignInParams params) =>
      _repo.signIn(params.email, params.password);
}

@lazySingleton
class SignUp implements UseCase<Unit, SignUpParams> {
  SignUp(this._repo);
  final AuthRepository _repo;
  @override
  Future<Result<Unit>> call(SignUpParams params) =>
      _repo.signUp(params.name, params.email, params.password);
}

@lazySingleton
class VerifyOtp implements UseCase<Unit, String> {
  VerifyOtp(this._repo);
  final AuthRepository _repo;
  @override
  Future<Result<Unit>> call(String code) => _repo.verifyOtp(code);
}

@lazySingleton
class RequestPasswordReset implements UseCase<Unit, String> {
  RequestPasswordReset(this._repo);
  final AuthRepository _repo;
  @override
  Future<Result<Unit>> call(String email) => _repo.requestPasswordReset(email);
}
