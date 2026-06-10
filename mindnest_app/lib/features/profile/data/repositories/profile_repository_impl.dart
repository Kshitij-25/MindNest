import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl();

  @override
  Future<Result<UserProfile>> getProfile() async {
    try {
      return Ok(_fromJson(await wellnessApi.accountProfile()));
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  UserProfile _fromJson(Map<String, dynamic> j) {
    String s(Object? v, [String d = '']) => v is String ? v : d;
    final activity = (j['weekActivity'] as List?) ?? const [];
    return UserProfile(
      name: s(j['name'], 'You'),
      email: s(j['email']),
      checkIns: s(j['checkIns'], '0'),
      entries: s(j['entries'], '0'),
      streak: s(j['streak'], '0'),
      weekActivity: [
        for (final a in activity.cast<Map<String, dynamic>>())
          (
            icon: s(a['icon'], 'sparkle'),
            value: s(a['value'], '0'),
            label: s(a['label']),
            colorKey: s(a['colorKey'], 'primary'),
          ),
      ],
      moodWeek: (j['moodWeek'] as List?)?.cast<int>() ?? const [],
    );
  }
}
