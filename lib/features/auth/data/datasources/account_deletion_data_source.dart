import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';

/// How the user proves it's really them before their account is erased.
enum ReauthMethod { password, google }

/// Deletes the signed-in user's account from the device.
///
/// There is no server, so the client erases everything the rules let it own,
/// cancels upcoming sessions (so the other side is told), and finally deletes
/// the Firebase Auth user. Firebase requires a recent sign-in for that last
/// step, so we re-authenticate *first* — otherwise the data could be wiped
/// while the login survives.
///
/// Kept for the other party: past appointment records, chat history and any
/// reviews the user wrote (reviews only store a first name).
abstract interface class AccountDeletionDataSource {
  ReauthMethod get reauthMethod;
  Future<void> deleteAccount({String? password});
}

@LazySingleton(as: AccountDeletionDataSource)
class FirebaseAccountDeletionDataSource implements AccountDeletionDataSource {
  FirebaseAccountDeletionDataSource(this._auth, this._db, this._google);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final GoogleSignIn _google;

  static const _userCollections = [
    'private',
    'moods',
    'journal',
    'likedPosts',
    'savedPosts',
    'savedTherapists',
    'fcmTokens',
    'notifications',
    'blocked',
  ];

  @override
  ReauthMethod get reauthMethod =>
      (_auth.currentUser?.providerData ?? const []).any((p) => p.providerId == 'password')
          ? ReauthMethod.password
          : ReauthMethod.google;

  @override
  Future<void> deleteAccount({String? password}) async {
    final user = _auth.currentUser;
    if (user == null) throw const UnauthenticatedException();
    await _reauthenticate(user, password);

    final uid = user.uid;
    final profile = (await _db.user(uid).get()).data() ?? const {};
    final isPro = profile['role'] == 'professional';

    await _cancelUpcoming(uid, isPro);
    await _deleteWhere(_db.collectionGroup('comments').where('authorId', isEqualTo: uid));
    if (isPro) {
      await _deleteWhere(_db.posts.where('authorId', isEqualTo: uid));
      final pro = _db.therapist(uid);
      for (final client in (await pro.collection('clients').get()).docs) {
        await _deleteQuery(client.reference.collection('notes'));
        await _deleteQuery(client.reference.collection('goals'));
        await client.reference.delete();
      }
      await _deleteQuery(pro.collection('busy'));
      await pro.delete();
    }
    await _deleteVerificationFiles(uid);
    for (final name in _userCollections) {
      await _deleteQuery(_db.userCol(uid, name));
    }
    await _db.collection('avatars').doc(uid).delete();
    await _db.user(uid).delete();

    await user.delete();
    try {
      await _google.signOut();
    } catch (_) {}
  }

  Future<void> _reauthenticate(User user, String? password) async {
    try {
      if (reauthMethod == ReauthMethod.password) {
        if (password == null || password.isEmpty) throw const ServerException('Enter your password to continue.');
        await user.reauthenticateWithCredential(EmailAuthProvider.credential(email: user.email!, password: password));
      } else {
        await _google.initialize();
        final account = await _google.authenticate();
        final idToken = account.authentication.idToken;
        if (idToken == null) throw const ServerException('Google sign-in was cancelled.');
        await user.reauthenticateWithCredential(GoogleAuthProvider.credential(idToken: idToken));
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(switch (e.code) {
        'wrong-password' || 'invalid-credential' => 'That password isn’t right.',
        'user-mismatch' => 'Sign in with the same account you’re deleting.',
        _ => e.message ?? 'Couldn’t confirm it’s you. Please try again.',
      });
    }
  }

  /// Future sessions are cancelled (and their slot locks released) so the
  /// other person isn't left waiting. Past records stay.
  Future<void> _cancelUpcoming(String uid, bool isPro) async {
    final snap = await _db.appointments.where(isPro ? 'therapistId' : 'clientId', isEqualTo: uid).get();
    final now = DateTime.now();
    final batch = _db.batch();
    for (final a in snap.docs) {
      final d = a.data();
      final startsAt = readDate(d['startsAt']);
      if (!startsAt.isAfter(now) || !['pending', 'accepted'].contains(d['status'])) continue;
      batch
        ..update(a.reference, {'status': 'cancelled', 'cancelledAt': FieldValue.serverTimestamp()})
        ..delete(_db.therapist(d['therapistId'] as String).collection('busy').doc(slotKey(startsAt)));
    }
    await batch.commit();
  }

  Future<void> _deleteVerificationFiles(String uid) async {
    final files = _db.userCol(uid, 'verificationFiles');
    for (final f in (await files.get()).docs) {
      await _deleteQuery(f.reference.collection('chunks'));
      await f.reference.delete();
    }
  }

  Future<void> _deleteQuery(CollectionReference<Map<String, dynamic>> col) => _deleteWhere(col);

  /// Deletes every document matched by [q], 400 per batch.
  Future<void> _deleteWhere(Query<Map<String, dynamic>> q) async {
    while (true) {
      final snap = await q.limit(400).get();
      if (snap.docs.isEmpty) return;
      final batch = _db.batch();
      for (final d in snap.docs) {
        batch.delete(d.reference);
      }
      await batch.commit();
      if (snap.docs.length < 400) return;
    }
  }
}
