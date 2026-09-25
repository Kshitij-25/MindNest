import 'package:fpdart/fpdart.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Runs a data-source call and maps exceptions to [Failure]s.
Future<Either<Failure, T>> guard<T>(Future<T> Function() run) async {
  try {
    return Right(await run());
  } on NotFoundException {
    return const Left(NotFoundFailure());
  } on NetworkException {
    return const Left(NetworkFailure());
  } on CacheException {
    return const Left(CacheFailure());
  } on ServerException catch (e) {
    return Left(
      e.message == null ? const ServerFailure() : ServerFailure(e.message!),
    );
  } catch (_) {
    return const Left(ServerFailure());
  }
}
