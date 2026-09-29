import 'package:cloud_firestore/cloud_firestore.dart';

import '../push/push_sender.dart';
import 'collections.dart';

/// Writes in-app notifications to another user's inbox
/// (`users/{uid}/notifications`) and sends the matching device push.
/// Use [add] to queue the item on a batch, then [commit] the batch: the push
/// only goes out once the write has succeeded.
abstract final class Inbox {
  static final _pending = Expando<List<Future<void> Function()>>();

  /// Commits [batch], then sends the pushes queued on it by [add].
  static Future<void> commit(WriteBatch batch) async {
    await batch.commit();
    for (final send in _pending[batch] ?? const <Future<void> Function()>[]) {
      send().ignore();
    }
  }

  /// Adds a notification to [batch]. Passing [id] makes it idempotent — e.g.
  /// one rolling "new message" item per conversation.
  static void add(
    WriteBatch batch,
    FirebaseFirestore db, {
    required String to,
    required String from,
    required String type,
    required String title,
    required String body,
    String? targetId,
    String? id,
  }) {
    final col = db.userCol(to, 'notifications');
    batch.set(id == null ? col.doc() : col.doc(id), {
      'type': type,
      'title': title,
      'body': body,
      'targetId': targetId,
      'senderId': from,
      'unread': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
    (_pending[batch] ??= []).add(
      () => PushSender.send(to: to, type: type, title: title, body: body, targetId: targetId),
    );
  }
}
