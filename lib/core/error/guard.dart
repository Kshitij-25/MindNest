import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  } on SocketException {
    return const Left(NetworkFailure());
  } on CacheException {
    return const Left(CacheFailure());
  } on UnauthenticatedException {
    return const Left(ServerFailure('Your session has ended. Please sign in again.'));
  } on ServerException catch (e) {
    return Left(
      e.message == null ? const ServerFailure() : ServerFailure(e.message!),
    );
  } on FirebaseAuthException catch (e) {
    return Left(_authFailure(e));
  } on GoogleSignInException catch (e) {
    return Left(
      e.code == GoogleSignInExceptionCode.canceled
          ? const ServerFailure('Sign-in was cancelled.')
          : const ServerFailure('Google sign-in failed. Please try again.'),
    );
  } on FirebaseException catch (e) {
    return Left(_firebaseFailure(e));
  } catch (_) {
    return const Left(ServerFailure());
  }
}

Failure _authFailure(FirebaseAuthException e) => switch (e.code) {
      'invalid-credential' || 'wrong-password' || 'user-not-found' || 'invalid-login-credentials' =>
        const ServerFailure('That email and password don’t match.'),
      'email-already-in-use' => const ValidationFailure('An account already exists for that email.'),
      'invalid-email' => const ValidationFailure('Please enter a valid email.'),
      'weak-password' => const ValidationFailure('Use a stronger password (at least 6 characters).'),
      'user-disabled' => const ServerFailure('This account has been disabled.'),
      'too-many-requests' => const ServerFailure('Too many attempts. Please wait a moment and try again.'),
      'network-request-failed' => const NetworkFailure(),
      'account-exists-with-different-credential' =>
        const ServerFailure('This email is registered with a different sign-in method.'),
      'requires-recent-login' => const ServerFailure('Please sign in again to continue.'),
      _ => ServerFailure(e.message ?? 'Authentication failed. Please try again.'),
    };

Failure _firebaseFailure(FirebaseException e) => switch (e.code) {
      'unavailable' || 'deadline-exceeded' => const NetworkFailure(),
      'not-found' => const NotFoundFailure(),
      'permission-denied' => const ServerFailure('You don’t have access to that.'),
      'already-exists' => const ServerFailure('That was just taken — please pick another.'),
      _ => const ServerFailure(),
    };
