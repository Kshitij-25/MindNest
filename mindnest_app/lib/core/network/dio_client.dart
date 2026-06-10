import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/app_config.dart';
import '../error/error_mapper.dart';
import '../error/exceptions.dart';
import '../services/session_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Thin wrapper over [Dio] that centralizes configuration and converts
/// transport errors into typed [AppException]s.
@lazySingleton
class DioClient {
  DioClient(SessionService session) : _dio = _build(session);

  final Dio _dio;
  Dio get raw => _dio;

  static Dio _build(SessionService session) {
    final env = AppConfig.instance.env;
    final dio = Dio(
      BaseOptions(
        baseUrl: env.apiBaseUrl,
        connectTimeout: env.connectTimeout,
        receiveTimeout: env.receiveTimeout,
        contentType: Headers.jsonContentType,
      ),
    );
    dio.interceptors.addAll([
      AuthInterceptor(session),
      RetryInterceptor(dio),
      if (env.enableNetworkLogs)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
        ),
    ]);
    return dio;
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) =>
      _guard(() => _dio.get<T>(path, queryParameters: query));

  Future<Response<T>> post<T>(String path, {Object? data}) =>
      _guard(() => _dio.post<T>(path, data: data));

  /// POST an `application/x-www-form-urlencoded` body (OAuth2 token endpoints).
  Future<Response<T>> postForm<T>(
    String path, {
    required Map<String, dynamic> fields,
  }) => _guard(
    () => _dio.post<T>(
      path,
      data: fields,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    ),
  );

  Future<Response<T>> put<T>(String path, {Object? data}) =>
      _guard(() => _dio.put<T>(path, data: data));

  Future<Response<T>> patch<T>(String path, {Object? data}) =>
      _guard(() => _dio.patch<T>(path, data: data));

  Future<Response<T>> delete<T>(String path, {Object? data}) =>
      _guard(() => _dio.delete<T>(path, data: data));

  Future<Response<T>> _guard<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
