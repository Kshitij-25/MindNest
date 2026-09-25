import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

/// Appearance and accessibility are per-device (local). Notification
/// choices are also mirrored to `users/{uid}.notificationPrefs` so a server
/// sending pushes can respect them.
@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._local, this._db, this._session);
  final SettingsLocalDataSource _local;
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  @override
  ResultFuture<AppPreferences> load() => guard(() async => _local.read());

  @override
  ResultFuture<void> save(AppPreferences prefs) => guard(() async {
        await _local.write(prefs);
        final uid = _session.uidOrNull;
        if (uid == null) return;
        _db.user(uid).update({
          'notificationPrefs': {
            'dailyReminders': prefs.dailyReminders,
            'sessionReminders': prefs.sessionReminders,
            'messageAlerts': prefs.messageAlerts,
            'contentUpdates': prefs.contentUpdates,
          },
        }).ignore();
      });
}
