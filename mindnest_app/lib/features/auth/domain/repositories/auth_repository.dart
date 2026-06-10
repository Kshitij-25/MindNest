import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

abstract interface class AuthRepository {
  Future<Result<Unit>> signIn(String email, String password);
  Future<Result<Unit>> signUp(String name, String email, String password);
  Future<Result<Unit>> verifyOtp(String code);
  Future<Result<Unit>> requestPasswordReset(String email);
}
