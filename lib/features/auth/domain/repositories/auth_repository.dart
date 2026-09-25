import '../../../../core/usecase/usecase.dart';
import '../entities/app_user.dart';
import '../entities/user_role.dart';

abstract interface class AuthRepository {
  /// The signed-in user, read synchronously from the on-device cache. Null
  /// when Firebase has no session.
  AppUser? get cachedUser;

  /// Resolves the session on launch: cache first, then the remote profile.
  ResultFuture<AppUser?> restoreSession();

  /// Live profile updates (e.g. a professional's verification being approved).
  Stream<AppUser> watchUser(String uid);

  ResultFuture<AppUser> signIn({
    required String email,
    required String password,
    required UserRole role,
  });
  ResultFuture<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });
  ResultFuture<AppUser> socialSignIn({
    required String provider,
    required UserRole role,
  });
  ResultFuture<void> sendPasswordReset(String email);
  ResultFuture<void> checkEmailVerified();
  ResultFuture<void> resendVerificationEmail();
  ResultFuture<AppUser> updateUser(AppUser user);
  ResultFuture<void> signOut();
}
