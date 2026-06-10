import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/network/dio_client.dart';
import 'package:mindnest_app/core/services/session_service.dart';

/// Talks to the MindNest auth API (`/auth/*`). On a successful sign-in / sign-up
/// it stores the issued tokens in [SessionService] so the auth interceptor can
/// attach the bearer to every subsequent request.
@lazySingleton
class AuthRemoteDataSource {
  DioClient get _dio => getIt<DioClient>();
  SessionService get _session => getIt<SessionService>();

  Future<void> signIn(String email, String password) async {
    // OAuth2 form login — the API treats `username` as the email.
    final res = await _dio.postForm<Map<String, dynamic>>(
      '/auth/login',
      fields: {'username': email.trim(), 'password': password},
    );
    _storeTokens(res.data);
  }

  Future<void> signUp(String name, String email, String password) async {
    await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'email': email.trim(),
        'password': password,
        'display_name': name.trim().isEmpty ? null : name.trim(),
      },
    );
    // Register returns the user (no tokens) — log in to start a session.
    await signIn(email, password);
  }

  Future<void> verifyOtp(String code) async {
    // No OTP endpoint in the backend yet — accept locally.
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  Future<void> requestPasswordReset(String email) async {
    await _dio.post<Map<String, dynamic>>(
      '/auth/forgot-password',
      data: {'email': email.trim()},
    );
  }

  Future<void> signOut() async {
    final refresh = _session.refreshToken;
    if (refresh != null) {
      try {
        await _dio.post<Map<String, dynamic>>(
          '/auth/logout',
          data: {'refresh_token': refresh},
        );
      } catch (_) {
        // Best-effort revoke; clear locally regardless.
      }
    }
    _session.clear();
  }

  void _storeTokens(Map<String, dynamic>? data) {
    final access = data?['access_token'] as String?;
    if (access == null) return;
    _session.start(
      token: access,
      refreshToken: data?['refresh_token'] as String?,
    );
  }
}
