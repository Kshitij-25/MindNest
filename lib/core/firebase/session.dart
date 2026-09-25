import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';

/// The signed-in Firebase user, for data sources that scope reads/writes.
@lazySingleton
class FirebaseSession {
  const FirebaseSession(this._auth);
  final FirebaseAuth _auth;

  String? get uidOrNull => _auth.currentUser?.uid;

  String get uid => uidOrNull ?? (throw const UnauthenticatedException());
}
