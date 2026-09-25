import '../../../../core/usecase/usecase.dart';
import '../entities/app_user.dart';
import '../entities/user_role.dart';

abstract interface class AuthRepository {
  AppUser? get cachedUser;
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
  ResultFuture<void> verifyOtp(String code);
  ResultFuture<void> resendOtp();
  ResultFuture<AppUser> updateUser(AppUser user);
  ResultFuture<void> signOut();
}
