import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';
import '../models/app_user_model.dart';

/// Auth API backed by Firebase Auth, with the profile stored in `users/{uid}`.
abstract interface class AuthRemoteDataSource {
  String? get currentUid;
  Future<AppUserModel> signIn({
    required String email,
    required String password,
    required UserRole role,
  });
  Future<AppUserModel> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });
  Future<AppUserModel> socialSignIn({
    required String provider,
    required UserRole role,
  });
  Future<AppUserModel?> currentProfile();
  Stream<AppUserModel?> watchProfile(String uid);
  Future<void> sendPasswordReset(String email);
  Future<void> checkEmailVerified();
  Future<void> resendVerificationEmail();
  Future<AppUserModel> updateProfile(AppUserModel user);
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource(this._auth, this._db, this._google);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final GoogleSignIn _google;
  Future<void>? _googleInit;

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Future<AppUserModel> signIn({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _ensureProfile(cred.user!, role);
  }

  @override
  Future<AppUserModel> signUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = cred.user!;
    await user.updateDisplayName(name);
    await user.sendEmailVerification();
    return _ensureProfile(user, role, name: name);
  }

  @override
  Future<AppUserModel> socialSignIn({
    required String provider,
    required UserRole role,
  }) async {
    if (provider != 'google') {
      throw const ServerException('That sign-in method isn’t available yet.');
    }
    await (_googleInit ??= _google.initialize());
    final account = await _google.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) throw const ServerException('Google sign-in failed. Please try again.');
    final cred = await _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: idToken));
    return _ensureProfile(cred.user!, role, name: account.displayName);
  }

  /// Loads the profile, creating it on first sign-in. An existing account
  /// keeps its original role, whichever door the user came in through.
  Future<AppUserModel> _ensureProfile(User user, UserRole role, {String? name}) async {
    final ref = _db.user(user.uid);
    final snap = await ref.get();
    if (snap.exists) return _fromDoc(snap);

    final displayName = (name ?? user.displayName ?? '').trim().isNotEmpty
        ? (name ?? user.displayName)!.trim()
        : (user.email ?? 'Friend').split('@').first;
    final model = AppUserModel(
      id: user.uid,
      name: displayName,
      email: user.email ?? '',
      role: role,
      maskedPhone: '',
      title: role == UserRole.professional ? 'Therapist' : null,
    );
    final batch = _db.batch()
      ..set(ref, {
        ..._toDoc(model),
        'createdAt': FieldValue.serverTimestamp(),
      });
    if (role == UserRole.professional) {
      // Directory profile; hidden until an admin marks it verified.
      batch.set(_db.therapist(user.uid), {
        'name': displayName,
        'title': 'Therapist',
        'spec': '',
        'tags': <String>[],
        'rating': 0,
        'reviews': 0,
        'years': 0,
        'verified': false,
        'price': 80,
        'location': 'Remote',
        'langs': ['English'],
        'about': '',
        'quals': <String>[],
        'types': ['Video', 'Voice', 'Chat'],
        'acceptingClients': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
    return model;
  }

  @override
  Future<AppUserModel?> currentProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final snap = await _db.user(user.uid).get();
    return snap.exists ? _fromDoc(snap) : _ensureProfile(user, UserRole.client);
  }

  @override
  Stream<AppUserModel?> watchProfile(String uid) =>
      _db.user(uid).snapshots().map((s) => s.exists ? _fromDoc(s) : null);

  @override
  Future<void> sendPasswordReset(String email) => _auth.sendPasswordResetEmail(email: email);

  @override
  Future<void> checkEmailVerified() async {
    final user = _auth.currentUser;
    if (user == null) throw const UnauthenticatedException();
    await user.reload();
    if (!(_auth.currentUser?.emailVerified ?? false)) {
      throw const ServerException(
        'We haven’t seen your confirmation yet — tap the link in the email, then try again.',
      );
    }
  }

  @override
  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user == null) throw const UnauthenticatedException();
    await user.sendEmailVerification();
  }

  @override
  Future<AppUserModel> updateProfile(AppUserModel m) async {
    final user = _auth.currentUser;
    if (user == null) throw const UnauthenticatedException();
    // A new email only takes effect once confirmed from the inbox.
    final currentEmail = user.email ?? m.email;
    if (m.email.isNotEmpty && m.email != currentEmail) {
      await user.verifyBeforeUpdateEmail(m.email);
    }
    // Users may only move verification forward to `pending`; approval is
    // done by an admin (scripts/approve_pro.mjs) and enforced by rules.
    await _db.user(m.id).update({
      'name': m.name,
      'onboarded': m.onboarded,
      'verification': m.verification.name,
      'title': m.title,
    });
    if (m.role == UserRole.professional) {
      await _db.therapist(m.id).update({'name': m.name, if (m.title != null) 'title': m.title});
    }
    if (user.displayName != m.name) await user.updateDisplayName(m.name);
    return AppUserModel(
      id: m.id,
      name: m.name,
      email: currentEmail,
      role: m.role,
      maskedPhone: m.maskedPhone,
      onboarded: m.onboarded,
      verification: m.verification,
      title: m.title,
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await (_googleInit ??= _google.initialize());
      await _google.signOut();
    } catch (_) {
      // Not signed in with Google on this device.
    }
    await _auth.signOut();
  }

  static AppUserModel _fromDoc(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    return AppUserModel(
      id: s.id,
      name: d['name'] as String? ?? '',
      email: d['email'] as String? ?? '',
      role: UserRole.values.asNameMap()[d['role']] ?? UserRole.client,
      maskedPhone: _mask(d['phone'] as String? ?? ''),
      onboarded: d['onboarded'] as bool? ?? false,
      verification: VerificationStatus.values.asNameMap()[d['verification']] ?? VerificationStatus.none,
      title: d['title'] as String?,
    );
  }

  static Map<String, dynamic> _toDoc(AppUserModel m) => {
        'name': m.name,
        'email': m.email,
        'role': m.role.name,
        'onboarded': m.onboarded,
        'verification': m.verification.name,
        'title': m.title,
        'phone': '',
        'bio': '',
      };

  static String _mask(String phone) {
    final digits = phone.replaceAll(RegExp(r'\s'), '');
    if (digits.length < 6) return phone;
    return '${digits.substring(0, 3)} ••• ••${digits.substring(digits.length - 3)}';
  }
}
