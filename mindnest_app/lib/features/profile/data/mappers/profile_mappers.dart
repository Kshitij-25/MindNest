import '../../domain/entities/user_profile.dart';
import '../models/profile_models.dart';

extension ProfileModelX on ProfileModel {
  UserProfile toEntity() => UserProfile(
    name: name,
    email: email,
    checkIns: checkIns,
    entries: entries,
    streak: streak,
    weekActivity: weekActivity.map((a) => a.toRecord()).toList(),
    moodWeek: moodWeek,
  );
}

extension ProfileActivityModelX on ProfileActivityModel {
  ({String icon, String value, String label, String colorKey}) toRecord() =>
      (icon: icon, value: value, label: label, colorKey: colorKey);
}
