import 'package:dio/dio.dart';
import 'package:mindnest_app/core/error/exceptions.dart';
import 'package:mindnest_app/core/error/failures.dart';

/// Converts a low-level [DioException] into a typed [AppException] for the
/// data layer.
AppException mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutException();
    case DioExceptionType.connectionError:
      return const NetworkException();
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      if (code == 401) return const UnauthorizedException();
      return ServerException(
        _messageFromResponse(e.response) ?? 'Server error',
        statusCode: code,
      );
    case DioExceptionType.cancel:
      return const UnknownException('Request cancelled');
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return const UnknownException();
  }
}

String? _messageFromResponse(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map && data['message'] is String) {
    return data['message'] as String;
  }
  return null;
}

/// Converts any thrown object into a domain [Failure]. Called by repositories.
Failure mapErrorToFailure(Object error) {
  if (error is AppException) {
    return switch (error) {
      NetworkException() => const NetworkFailure(),
      TimeoutException() => const TimeoutFailure(),
      UnauthorizedException() => const AuthFailure(),
      ServerException() => ServerFailure(error.message),
      CacheException() => CacheFailure(error.message),
      UnknownException() => UnexpectedFailure(error.message),
    };
  }
  if (error is DioException) return mapErrorToFailure(mapDioException(error));
  return const UnexpectedFailure();
}
