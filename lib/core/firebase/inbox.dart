import 'package:cloud_firestore/cloud_firestore.dart';

import 'collections.dart';

/// Writes in-app notifications to another user's inbox
/// (`users/{uid}/notifications`). On the Spark plan the acting client writes
/// them; with Cloud Functions these docs are also the trigger for FCM pushes
/// (see `functions/`).
abstract final class Inbox {
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
  }
}
