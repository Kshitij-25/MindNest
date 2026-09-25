import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/assessment_model.dart';

abstract interface class OnboardingLocalDataSource {
  AssessmentModel? read();
  Future<void> write(AssessmentModel model);
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;
  static const _key = 'assessment_v1';

  @override
  AssessmentModel? read() {
    final raw = _prefs.getString(_key);
    return raw == null ? null : AssessmentModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> write(AssessmentModel model) => _prefs.setString(_key, jsonEncode(model.toJson()));
}
