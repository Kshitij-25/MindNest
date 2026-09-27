import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../models/therapist_model.dart';
import '../../../safety/data/safety_data_source.dart';

abstract interface class TherapistDataSource {
  Future<List<TherapistModel>> therapists();
  Future<TherapistModel> therapist(String id);
  Future<List<ReviewModel>> reviews(String therapistId);
  Future<Set<String>> savedIds();
  Future<bool> toggleSaved(String id);
}

/// Public directory in `therapists/`; only verified professionals are listed.
@LazySingleton(as: TherapistDataSource)
class FirestoreTherapistDataSource implements TherapistDataSource {
  FirestoreTherapistDataSource(this._db, this._session, this._safety);
  final FirebaseFirestore _db;
  final FirebaseSession _session;
  final SafetyDataSource _safety;

  CollectionReference<Map<String, dynamic>> get _saved => _db.userCol(_session.uid, 'savedTherapists');

  @override
  Future<List<TherapistModel>> therapists() async {
    final snap = await _db.collection(Col.therapists).where('verified', isEqualTo: true).get();
    final blocked = await _safety.blockedIds();
    return snap.docs.where((d) => !blocked.contains(d.id)).map(TherapistModel.fromFirestore).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }

  @override
  Future<TherapistModel> therapist(String id) async {
    final snap = await _db.therapist(id).get();
    if (!snap.exists) throw const NotFoundException();
    return TherapistModel.fromFirestore(snap);
  }

  @override
  Future<List<ReviewModel>> reviews(String therapistId) async {
    final snap = await _db
        .therapist(therapistId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();
    return snap.docs.map(ReviewModel.fromFirestore).toList();
  }

  @override
  Future<Set<String>> savedIds() async => (await _saved.get()).docs.map((d) => d.id).toSet();

  @override
  Future<bool> toggleSaved(String id) async {
    final ref = _saved.doc(id);
    if ((await ref.get()).exists) {
      await ref.delete();
      return false;
    }
    await ref.set({'savedAt': FieldValue.serverTimestamp()});
    return true;
  }
}
