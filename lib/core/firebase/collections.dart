import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore layout. Keep in sync with `firestore.rules`.
///
/// ```
/// users/{uid}                         profile (role, onboarding, verification…)
///   private/{assessment|verification|preferences}
///   moods/{id} · journal/{id} · notifications/{id}
///   likedPosts/{postId} · savedPosts/{postId} · savedTherapists/{id}
///   fcmTokens/{token}
/// therapists/{uid}                    public directory profile of a professional
///   reviews/{id} · busy/{slotKey}
///   clients/{clientUid} → notes/{id} · goals/{id}   (practitioner-only)
/// appointments/{id}                   bookings: client ⇄ professional
/// conversations/{clientUid_proUid} → messages/{id}
/// posts/{id} → comments/{id} · likes/{uid}
/// ```
abstract final class Col {
  static const users = 'users';
  static const therapists = 'therapists';
  static const appointments = 'appointments';
  static const conversations = 'conversations';
  static const posts = 'posts';
}

extension FirestorePaths on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> user(String uid) => collection(Col.users).doc(uid);
  CollectionReference<Map<String, dynamic>> userCol(String uid, String name) => user(uid).collection(name);
  DocumentReference<Map<String, dynamic>> private(String uid, String name) => userCol(uid, 'private').doc(name);
  DocumentReference<Map<String, dynamic>> therapist(String uid) => collection(Col.therapists).doc(uid);
  CollectionReference<Map<String, dynamic>> get appointments => collection(Col.appointments);
  CollectionReference<Map<String, dynamic>> get conversations => collection(Col.conversations);
  CollectionReference<Map<String, dynamic>> get posts => collection(Col.posts);
}

/// Reads a Firestore timestamp (or ISO string / null) as a [DateTime].
DateTime readDate(Object? v, [DateTime? fallback]) => switch (v) {
      Timestamp t => t.toDate(),
      String s => DateTime.tryParse(s) ?? fallback ?? DateTime.now(),
      _ => fallback ?? DateTime.now(),
    };

List<String> readStrings(Object? v) => v is List ? v.map((e) => '$e').toList() : const [];

int readInt(Object? v, [int fallback = 0]) => v is num ? v.toInt() : fallback;

/// Stable key for a booking slot, used as the lock document id.
String slotKey(DateTime t) =>
    '${t.year}${t.month.toString().padLeft(2, '0')}${t.day.toString().padLeft(2, '0')}'
    '${t.hour.toString().padLeft(2, '0')}${t.minute.toString().padLeft(2, '0')}';
