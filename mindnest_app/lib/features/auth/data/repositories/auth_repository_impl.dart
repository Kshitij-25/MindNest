import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<Result<Unit>> signIn(String email, String password) async {
    try {
      await _remote.signIn(email, password);
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Unit>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      await _remote.signUp(name, email, password);
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Unit>> verifyOtp(String code) async {
    try {
      await _remote.verifyOtp(code);
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Unit>> requestPasswordReset(String email) async {
    try {
      await _remote.requestPasswordReset(email);
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
