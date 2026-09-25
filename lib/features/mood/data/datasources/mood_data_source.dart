import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../models/mood_entry_model.dart';

abstract interface class MoodDataSource {
  /// Entries since [since], newest first.
  Future<List<MoodEntryModel>> entries({required DateTime since});
  Future<MoodEntryModel> log({required int level, required List<String> factors, required String note});
}

/// Private check-ins at `users/{uid}/moods/{id}`.
@LazySingleton(as: MoodDataSource)
class FirestoreMoodDataSource implements MoodDataSource {
  FirestoreMoodDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  CollectionReference<Map<String, dynamic>> get _col => _db.userCol(_session.uid, 'moods');

  @override
  Future<List<MoodEntryModel>> entries({required DateTime since}) async {
    final snap = await _col
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
        .orderBy('createdAt', descending: true)
        .get();
    return [
      for (final s in snap.docs)
        MoodEntryModel(
          id: s.id,
          level: readInt(s.data()['level'], 3),
          createdAt: readDate(s.data()['createdAt']),
          factors: readStrings(s.data()['factors']),
          note: s.data()['note'] as String? ?? '',
        ),
    ];
  }

  @override
  Future<MoodEntryModel> log({required int level, required List<String> factors, required String note}) async {
    final now = DateTime.now();
    final ref = await _col.add({
      'level': level,
      'factors': factors,
      'note': note,
      'createdAt': Timestamp.fromDate(now),
    });
    return MoodEntryModel(id: ref.id, level: level, createdAt: now, factors: factors, note: note);
  }
}
