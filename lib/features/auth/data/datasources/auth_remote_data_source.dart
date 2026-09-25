import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../models/app_user_model.dart';

/// Auth API. The mock implementation accepts any well-formed credentials;
/// replace with a Dio-backed implementation when the backend is ready.
abstract interface class AuthRemoteDataSource {
  Future<AppUserModel> signIn({
    required String email,
    required String password,
    required UserRole role,
  });
  Future<AppUserModel> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });
  Future<AppUserModel> socialSignIn({
    required String provider,
    required UserRole role,
  });
  Future<void> sendPasswordReset(String email);
  Future<void> verifyOtp(String code);
  Future<void> resendOtp();
}

@LazySingleton(as: AuthRemoteDataSource)
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  AppUserModel _demo(UserRole role, {String? name, String? email}) =>
      role == UserRole.professional
      ? AppUserModel(
          id: 'pro-1',
          name: name ?? 'Dr. Evelyn Hale',
          email: email ?? 'evelyn@hale.practice',
          role: role,
          onboarded: true,
          verification: VerificationStatus.verified,
          title: 'Clinical Psychologist',
        )
      : AppUserModel(
          id: 'user-1',
          name: name ?? 'Maya Chen',
          email: email ?? 'maya.chen@mail.com',
          role: role,
          onboarded: true,
        );

  @override
  Future<AppUserModel> signIn({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    await mockLatency(600);
    if (password.isNotEmpty && password.length < 6) {
      throw const ServerException('That email and password don’t match.');
    }
    return _demo(role, email: email.isEmpty ? null : email);
  }

  @override
  Future<AppUserModel> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    await mockLatency(700);
    final u = _demo(role, name: name, email: email);
    return AppUserModel(
      id: u.id,
      name: u.name,
      email: u.email,
      role: role,
      onboarded: false,
      verification: VerificationStatus.none,
      title: u.title,
    );
  }

  @override
  Future<AppUserModel> socialSignIn({
    required String provider,
    required UserRole role,
  }) async {
    await mockLatency(700);
    return _demo(role);
  }

  @override
  Future<void> sendPasswordReset(String email) => mockLatency(700);

  @override
  Future<void> verifyOtp(String code) async {
    await mockLatency(500);
    if (code.length != 6) throw const ServerException('Enter all 6 digits.');
  }

  @override
  Future<void> resendOtp() => mockLatency(300);
}
