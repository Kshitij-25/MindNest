import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
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

/// Private copy of the questionnaire at `users/{uid}/private/assessment`
/// (used to give practitioners a booking reason).
abstract interface class OnboardingRemoteDataSource {
  Future<AssessmentModel?> read();
  Future<void> write(AssessmentModel model);
}

@LazySingleton(as: OnboardingRemoteDataSource)
class FirestoreOnboardingDataSource implements OnboardingRemoteDataSource {
  FirestoreOnboardingDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  DocumentReference<Map<String, dynamic>> get _doc => _db.private(_session.uid, 'assessment');

  @override
  Future<AssessmentModel?> read() async {
    final d = (await _doc.get()).data();
    return d == null ? null : AssessmentModel.fromJson(d);
  }

  @override
  Future<void> write(AssessmentModel model) =>
      _doc.set({...model.toJson(), 'updatedAt': FieldValue.serverTimestamp()});
}
