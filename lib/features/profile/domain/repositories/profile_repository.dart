import '../../../../core/usecase/usecase.dart';
import '../entities/profile_details.dart';

abstract interface class ProfileRepository {
  ResultFuture<ProfileDetails> getDetails();
  ResultFuture<void> saveDetails(ProfileDetails details);
}
