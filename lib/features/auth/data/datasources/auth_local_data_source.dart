import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user_model.dart';

/// Persists the signed-in session on device.
abstract interface class AuthLocalDataSource {
  AppUserModel? readUser();
  Future<void> writeUser(AppUserModel user);
  Future<void> clear();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;
  static const _key = 'session_user_v1';

  @override
  AppUserModel? readUser() {
    final raw = _prefs.getString(_key);
    if (raw == null) return null;
    return AppUserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> writeUser(AppUserModel user) =>
      _prefs.setString(_key, jsonEncode(user.toJson()));

  @override
  Future<void> clear() => _prefs.remove(_key);
}
