import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../../domain/entities/profile_details.dart';

/// Phone and bio on the user's profile doc (`users/{uid}`).
abstract interface class ProfileDataSource {
  Future<ProfileDetails> read();
  Future<void> write(ProfileDetails d);
}

@LazySingleton(as: ProfileDataSource)
class FirestoreProfileDataSource implements ProfileDataSource {
  FirestoreProfileDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  @override
  Future<ProfileDetails> read() async {
    final d = (await _db.user(_session.uid).get()).data() ?? const {};
    return ProfileDetails(phone: d['phone'] as String? ?? '', bio: d['bio'] as String? ?? '');
  }

  @override
  Future<void> write(ProfileDetails d) => _db.user(_session.uid).update({'phone': d.phone, 'bio': d.bio});
}
