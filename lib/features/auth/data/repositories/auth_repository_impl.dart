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
  AppUser? get cachedUser {
    final uid = _remote.currentUid;
    final cached = _local.readUser();
    return uid != null && cached?.id == uid ? cached!.toEntity() : null;
  }

  Future<AppUser> _persist(AppUserModel m) async {
    await _local.writeUser(m);
    return m.toEntity();
  }

  @override
  ResultFuture<AppUser?> restoreSession() => guard(() async {
    if (_remote.currentUid == null) {
      await _local.clear();
      return null;
    }
    final cached = cachedUser;
    if (cached != null) return cached;
    final remote = await _remote.currentProfile();
    return remote == null ? null : _persist(remote);
  });

  @override
  Stream<AppUser> watchUser(String uid) => _remote
      .watchProfile(uid)
      .where((m) => m != null)
      .asyncMap((m) => _persist(m!));

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
  ResultFuture<void> checkEmailVerified() =>
      guard(() => _remote.checkEmailVerified());

  @override
  ResultFuture<void> resendVerificationEmail() =>
      guard(() => _remote.resendVerificationEmail());

  @override
  ResultFuture<AppUser> updateUser(AppUser user) => guard(
    () async =>
        _persist(await _remote.updateProfile(AppUserModel.fromEntity(user))),
  );

  @override
  ResultFuture<void> signOut() => guard(() async {
    await _remote.signOut();
    await _local.clear();
  });
}
