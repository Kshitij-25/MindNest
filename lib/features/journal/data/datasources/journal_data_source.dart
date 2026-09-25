import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../models/journal_entry_model.dart';

abstract interface class JournalDataSource {
  Future<List<JournalEntryModel>> entries();
  Future<JournalEntryModel> upsert(JournalEntryModel model);
  Future<void> delete(String id);
}

/// Private entries at `users/{uid}/journal/{id}`.
@LazySingleton(as: JournalDataSource)
class FirestoreJournalDataSource implements JournalDataSource {
  FirestoreJournalDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  CollectionReference<Map<String, dynamic>> get _col => _db.userCol(_session.uid, 'journal');

  @override
  Future<List<JournalEntryModel>> entries() async {
    final snap = await _col.orderBy('createdAt', descending: true).get();
    return [
      for (final s in snap.docs)
        JournalEntryModel(
          id: s.id,
          title: s.data()['title'] as String? ?? '',
          body: s.data()['body'] as String? ?? '',
          mood: readInt(s.data()['mood'], 4),
          tags: readStrings(s.data()['tags']),
          createdAt: readDate(s.data()['createdAt']),
          draft: s.data()['draft'] as bool? ?? false,
          favourite: s.data()['favourite'] as bool? ?? false,
        ),
    ];
  }

  @override
  Future<JournalEntryModel> upsert(JournalEntryModel m) async {
    await _col.doc(m.id).set({
      'title': m.title,
      'body': m.body,
      'mood': m.mood,
      'tags': m.tags,
      'createdAt': Timestamp.fromDate(m.createdAt),
      'draft': m.draft,
      'favourite': m.favourite,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return m;
  }

  @override
  Future<void> delete(String id) async {
    final ref = _col.doc(id);
    if (!(await ref.get()).exists) throw const NotFoundException();
    await ref.delete();
  }
}
