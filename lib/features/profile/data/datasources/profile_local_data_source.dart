import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/profile_details.dart';

abstract interface class ProfileLocalDataSource {
  ProfileDetails read();
  Future<void> write(ProfileDetails d);
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  ProfileDetails read() => ProfileDetails(
        phone: _prefs.getString('profile_phone') ?? const ProfileDetails().phone,
        bio: _prefs.getString('profile_bio') ?? const ProfileDetails().bio,
      );

  @override
  Future<void> write(ProfileDetails d) async {
    await _prefs.setString('profile_phone', d.phone);
    await _prefs.setString('profile_bio', d.bio);
  }
}
