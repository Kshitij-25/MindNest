import '../error/result.dart';

/// Base contract for an application use case.
///
/// Use cases hold a single unit of business logic and sit between the
/// presentation layer (cubits) and the domain repositories.
abstract interface class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// Synchronous variant for trivial, non-async logic.
abstract interface class SyncUseCase<T, Params> {
  Result<T> call(Params params);
}

/// Marker for use cases that take no arguments.
class NoParams {
  const NoParams();
}

/// Empty success payload for commands that return no value.
class Unit {
  const Unit();
}

const unit = Unit();
