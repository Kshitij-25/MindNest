import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Profile photos, stored as small JPEGs in `avatars/{uid}` (no Cloud
/// Storage on the Spark plan). Readable by any signed-in user so photos show
/// in the directory, feed and chats; writable only by the owner.
///
/// Photos are cached for the app session; [changes] ticks when one is
/// updated so visible avatars refresh.
@lazySingleton
class AvatarStore {
  AvatarStore(this._db);
  final FirebaseFirestore _db;

  /// Upper bound enforced by the rules too.
  static const maxBytes = 150 * 1024;

  final _cache = <String, Future<Uint8List?>>{};
  final changes = ValueNotifier<int>(0);

  DocumentReference<Map<String, dynamic>> _doc(String uid) => _db.collection('avatars').doc(uid);

  Future<Uint8List?> load(String uid) => _cache[uid] ??= _fetch(uid);

  Future<Uint8List?> _fetch(String uid) async {
    try {
      final blob = (await _doc(uid).get()).data()?['data'];
      return blob is Blob ? blob.bytes : null;
    } catch (_) {
      _cache.remove(uid); // retry next time
      return null;
    }
  }

  Future<void> set(String uid, Uint8List jpeg) async {
    if (jpeg.length > maxBytes) throw ArgumentError('Photo is too large');
    await _doc(uid).set({'data': Blob(jpeg), 'updatedAt': FieldValue.serverTimestamp()});
    _cache[uid] = Future.value(jpeg);
    changes.value++;
  }

  Future<void> remove(String uid) async {
    await _doc(uid).delete();
    _cache[uid] = Future.value(null);
    changes.value++;
  }
}
