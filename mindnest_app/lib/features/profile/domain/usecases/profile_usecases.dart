import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetUserProfile implements UseCase<UserProfile, NoParams> {
  GetUserProfile(this._repo);
  final ProfileRepository _repo;
  @override
  Future<Result<UserProfile>> call(NoParams params) => _repo.getProfile();
}
