/// Data-layer exceptions; repositories map these to [Failure]s.
class ServerException implements Exception {
  const ServerException([this.message]);
  final String? message;
}

class NetworkException implements Exception {
  const NetworkException();
}

class CacheException implements Exception {
  const CacheException();
}

class NotFoundException implements Exception {
  const NotFoundException();
}
