/// Low-level exceptions thrown by the data layer. These are caught by
/// repositories and converted into [Failure]s for the domain layer.
sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType($message)';
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = 'The request timed out']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Session expired'])
    : super(statusCode: 401);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache error']);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'Something went wrong']);
}
