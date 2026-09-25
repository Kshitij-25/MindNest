import 'package:equatable/equatable.dart';

/// Domain-level failure returned in `Left` of repository calls.
sealed class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Something went wrong. Please try again.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No connection. Check your internet and try again.',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Could not read saved data.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'We couldn’t find that.']);
}
