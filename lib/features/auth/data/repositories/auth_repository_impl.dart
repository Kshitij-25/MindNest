import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/app_user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote, this._local);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  AppUser? get cachedUser => _local.readUser()?.toEntity();

  Future<AppUser> _persist(AppUserModel m) async {
    await _local.writeUser(m);
    return m.toEntity();
  }

  @override
  ResultFuture<AppUser> signIn({
    required String email,
    required String password,
    required UserRole role,
  }) => guard(
    () async => _persist(
      await _remote.signIn(email: email, password: password, role: role),
    ),
  );

  @override
  ResultFuture<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) => guard(
    () async => _persist(
      await _remote.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      ),
    ),
  );

  @override
  ResultFuture<AppUser> socialSignIn({
    required String provider,
    required UserRole role,
  }) => guard(
    () async =>
        _persist(await _remote.socialSignIn(provider: provider, role: role)),
  );

  @override
  ResultFuture<void> sendPasswordReset(String email) =>
      guard(() => _remote.sendPasswordReset(email));

  @override
  ResultFuture<void> verifyOtp(String code) =>
      guard(() => _remote.verifyOtp(code));

  @override
  ResultFuture<void> resendOtp() => guard(() => _remote.resendOtp());

  @override
  ResultFuture<AppUser> updateUser(AppUser user) =>
      guard(() => _persist(AppUserModel.fromEntity(user)));

  @override
  ResultFuture<void> signOut() => guard(() => _local.clear());
}
