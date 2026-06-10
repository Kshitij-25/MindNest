import 'package:dio/dio.dart';

/// Retries idempotent requests on transient network/timeout errors with a
/// small linear backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this._dio, {
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 400),
  });

  final Dio _dio;
  final int maxRetries;
  final Duration retryDelay;

  static const _retryKey = 'retry_count';

  bool _isTransient(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt = (err.requestOptions.extra[_retryKey] as int?) ?? 0;
    final method = err.requestOptions.method.toUpperCase();
    final idempotent = method == 'GET' || method == 'HEAD';

    if (!idempotent || !_isTransient(err) || attempt >= maxRetries) {
      return handler.next(err);
    }

    await Future<void>.delayed(retryDelay * (attempt + 1));
    final options = err.requestOptions..extra[_retryKey] = attempt + 1;
    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
