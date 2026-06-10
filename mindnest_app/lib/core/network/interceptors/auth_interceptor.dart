import 'package:dio/dio.dart';

import '../../services/session_service.dart';

/// Attaches the bearer token to every request and clears the session on 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._session);
  final SessionService _session;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _session.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _session.clear();
    }
    handler.next(err);
  }
}
