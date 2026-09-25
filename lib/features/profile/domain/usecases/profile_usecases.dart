import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/profile_details.dart';
import '../repositories/profile_repository.dart';

@injectable
class GetProfileDetails implements UseCase<ProfileDetails, NoParams> {
  const GetProfileDetails(this._repo);
  final ProfileRepository _repo;

  @override
  ResultFuture<ProfileDetails> call(NoParams _) => _repo.getDetails();
}

@injectable
class SaveProfileDetails implements UseCase<void, ProfileDetails> {
  const SaveProfileDetails(this._repo);
  final ProfileRepository _repo;

  @override
  ResultFuture<void> call(ProfileDetails d) => _repo.saveDetails(d);
}
