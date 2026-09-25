import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../../domain/entities/app_notification.dart';
import '../models/notification_model.dart';

abstract interface class NotificationsDataSource {
  Future<List<NotificationModel>> list();
  Stream<List<NotificationModel>> watch();
  Future<void> markRead(String id);
  Future<void> markAllRead();
}

/// Inbox at `users/{uid}/notifications`, written by whoever triggers the
/// event (booking, message…).
@LazySingleton(as: NotificationsDataSource)
class FirestoreNotificationsDataSource implements NotificationsDataSource {
  FirestoreNotificationsDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  CollectionReference<Map<String, dynamic>> get _col => _db.userCol(_session.uid, 'notifications');

  Query<Map<String, dynamic>> get _recent => _col.orderBy('createdAt', descending: true).limit(50);

  static NotificationModel fromDoc(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    return NotificationModel(
      id: s.id,
      type: NotificationType.values.asNameMap()[d['type']] ?? NotificationType.content,
      title: d['title'] as String? ?? '',
      body: d['body'] as String? ?? '',
      createdAt: readDate(d['createdAt']),
      unread: d['unread'] as bool? ?? false,
      targetId: d['targetId'] as String?,
    );
  }

  @override
  Future<List<NotificationModel>> list() async => (await _recent.get()).docs.map(fromDoc).toList();

  @override
  Stream<List<NotificationModel>> watch() => _recent.snapshots().map((s) => s.docs.map(fromDoc).toList());

  @override
  Future<void> markRead(String id) => _col.doc(id).update({'unread': false});

  @override
  Future<void> markAllRead() async {
    final unread = await _col.where('unread', isEqualTo: true).get();
    final batch = _db.batch();
    for (final d in unread.docs) {
      batch.update(d.reference, {'unread': false});
    }
    await batch.commit();
  }
}
