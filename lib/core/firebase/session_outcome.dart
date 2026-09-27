import 'package:cloud_firestore/cloud_firestore.dart';

import 'collections.dart';

/// An accepted session the professional hasn't marked (completed / no-show)
/// this long after it ends is completed automatically. There's no server,
/// so whichever participant opens the app first does it; `firestore.rules`
/// only allows the write once this window has really passed.
const autoCompleteAfter = Duration(hours: 24);

DateTime sessionEnd(Map<String, dynamic> d) =>
    readDate(d['startsAt']).add(Duration(minutes: readInt(d['minutes'], 50)));

/// Marks overdue accepted sessions in [docs] completed and returns their ids.
/// Best effort: a failed write just leaves them for the next load.
Future<Set<String>> autoCompleteOverdue(
  FirebaseFirestore db,
  Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
) async {
  // A few minutes' margin so a fast device clock can't trip the rule.
  final cutoff = DateTime.now().subtract(autoCompleteAfter + const Duration(minutes: 5));
  final overdue = docs.where((d) => d.data()['status'] == 'accepted' && sessionEnd(d.data()).isBefore(cutoff)).toList();
  if (overdue.isEmpty) return const {};
  final batch = db.batch();
  for (final d in overdue) {
    batch.update(d.reference, {'status': 'completed', 'completedBy': 'auto', 'completedAt': FieldValue.serverTimestamp()});
  }
  try {
    await batch.commit();
    return {for (final d in overdue) d.id};
  } catch (_) {
    return const {};
  }
}
