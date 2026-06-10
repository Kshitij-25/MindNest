import 'package:equatable/equatable.dart';

/// Domain-facing error type. Presentation maps these to user-friendly copy.
sealed class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Our servers had a hiccup. Please try again.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'You appear to be offline.']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'That took too long. Please try again.',
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Please sign in again.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Could not read saved data.']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Something went wrong.']);
}
