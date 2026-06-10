import 'package:mindnest_app/core/error/result.dart';

import '../entities/user_profile.dart';

abstract interface class ProfileRepository {
  Future<Result<UserProfile>> getProfile();
}
