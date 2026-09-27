import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/guard.dart';
import '../../../core/firebase/collections.dart';
import '../../../core/firebase/session.dart';
import '../../../core/usecase/usecase.dart';
import '../domain/safety.dart';

/// Reports go to `reports/` (write-only for users; moderators read them with
/// the Admin SDK — `npm run reports` in tool/firebase). Blocks live in
/// `users/{uid}/blocked/{otherUid}`; rules stop a blocked user messaging or
/// booking the blocker, and feeds filter them out via [blockedIds].
@lazySingleton
class SafetyDataSource {
  SafetyDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  String? _cacheOwner;
  Set<String>? _cache;

  CollectionReference<Map<String, dynamic>> get _blocked => _db.userCol(_session.uid, 'blocked');

  /// IDs the signed-in user has blocked. Cached per user; kept current by
  /// [block]/[unblock].
  Future<Set<String>> blockedIds() async {
    final uid = _session.uid;
    if (_cacheOwner == uid && _cache != null) return _cache!;
    final ids = (await _blocked.get()).docs.map((d) => d.id).toSet();
    _cacheOwner = uid;
    return _cache = ids;
  }

  Future<void> report(ReportSubject s, ReportReason reason, String details) => _db.collection('reports').add({
        'reporterId': _session.uid,
        'targetType': s.type.name,
        'targetPath': s.path,
        'targetOwnerId': s.ownerId,
        'targetOwnerName': s.ownerName,
        'reason': reason.name,
        'details': details.trim(),
        'status': 'open',
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<void> block(String userId, String name) async {
    await _blocked.doc(userId).set({'name': name, 'at': FieldValue.serverTimestamp()});
    (await blockedIds()).add(userId);
  }

  Future<void> unblock(String userId) async {
    await _blocked.doc(userId).delete();
    (await blockedIds()).remove(userId);
  }

  Future<List<BlockedUser>> blockedUsers() async {
    final snap = await _blocked.orderBy('at', descending: true).get();
    return [
      for (final d in snap.docs)
        BlockedUser(id: d.id, name: d.data()['name'] as String? ?? 'User', blockedAt: readDate(d.data()['at'])),
    ];
  }
}

@LazySingleton(as: SafetyRepository)
class SafetyRepositoryImpl implements SafetyRepository {
  SafetyRepositoryImpl(this._ds);
  final SafetyDataSource _ds;

  @override
  ResultFuture<void> report(ReportSubject subject, ReportReason reason, String details) =>
      guard(() => _ds.report(subject, reason, details));

  @override
  ResultFuture<void> block(String userId, String name) => guard(() => _ds.block(userId, name));

  @override
  ResultFuture<void> unblock(String userId) => guard(() => _ds.unblock(userId));

  @override
  ResultFuture<List<BlockedUser>> blockedUsers() => guard(_ds.blockedUsers);

  @override
  ResultFuture<bool> isBlocked(String userId) => guard(() async => (await _ds.blockedIds()).contains(userId));
}
