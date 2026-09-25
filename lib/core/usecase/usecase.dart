import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

abstract interface class UseCase<T, P> {
  ResultFuture<T> call(P params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
