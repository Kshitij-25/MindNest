import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../firebase_options.dart';
import '../firebase/collections.dart';
import '../router/app_router.dart';

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  // Notification payloads are shown by the OS; nothing else to do yet.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

/// Must be called before `runApp`.
void registerBackgroundPushHandler() {
  if (kIsWeb) return;
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
}

/// Push notifications.
///
/// * Registers this device's FCM token under `users/{uid}/fcmTokens/{token}`
///   so a server (Cloud Function in `functions/`) can target the user.
/// * Shows FCM messages that arrive while the app is in the foreground.
/// * Without a server (Spark plan) it also raises a local notification for
///   new inbox items while the app is alive in the background.
/// * Tapping any notification opens the Notifications screen.
@lazySingleton
class PushService with WidgetsBindingObserver {
  PushService(this._auth, this._db, this._messaging, this._settings, this._router);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseMessaging _messaging;
  final SettingsCubit _settings;
  final AppRouter _router;

  final _local = FlutterLocalNotificationsPlugin();
  static const _channel = AndroidNotificationDetails(
    'mindnest_default',
    'MindNest',
    channelDescription: 'Bookings, messages and reminders',
    importance: Importance.high,
    priority: Priority.high,
  );

  StreamSubscription<Object?>? _authSub, _tokenSub, _inboxSub;
  AppLifecycleState _lifecycle = AppLifecycleState.resumed;
  String? _token;
  bool _started = false;

  bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<void> start() async {
    if (_started || !_supported) return;
    _started = true;
    WidgetsBinding.instance.addObserver(this);

    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (_) => _openInbox(),
    );
    await _messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((m) {
      // iOS presents foreground alerts natively (options above).
      if (Platform.isAndroid && m.notification != null) {
        _show(m.notification!.title ?? 'MindNest', m.notification!.body ?? '');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((_) => _openInbox());
    final initial = await _messaging.getInitialMessage();
    if (initial != null) _openInbox();

    _authSub = _auth.authStateChanges().listen(_onUser);
  }

  Future<void> _onUser(User? user) async {
    await _inboxSub?.cancel();
    await _tokenSub?.cancel();
    if (user == null) return;
    try {
      final perm = await _messaging.requestPermission();
      if (Platform.isAndroid) {
        await _local
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }
      if (perm.authorizationStatus == AuthorizationStatus.denied) return;
      if (Platform.isIOS && await _messaging.getAPNSToken() == null) {
        // APNs not ready yet (simulator / no APNs key) — FCM token unavailable.
      } else {
        await _saveToken(user.uid, await _messaging.getToken());
      }
      _tokenSub = _messaging.onTokenRefresh.listen((t) => _saveToken(user.uid, t));
    } catch (e) {
      debugPrint('Push registration failed: $e');
    }
    _watchInbox(user.uid);
  }

  Future<void> _saveToken(String uid, String? token) async {
    if (token == null) return;
    _token = token;
    await _db.userCol(uid, 'fcmTokens').doc(token).set({
      'platform': Platform.operatingSystem,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Removes this device's token; call while still signed in.
  Future<void> unregister() async {
    final uid = _auth.currentUser?.uid;
    final token = _token;
    if (uid == null || token == null) return;
    try {
      await _db.userCol(uid, 'fcmTokens').doc(token).delete();
    } catch (_) {}
    _token = null;
  }

  void _watchInbox(String uid) {
    final since = Timestamp.now();
    _inboxSub = _db
        .userCol(uid, 'notifications')
        .where('createdAt', isGreaterThan: since)
        .snapshots()
        .listen((s) {
      if (_lifecycle == AppLifecycleState.resumed) return; // the in-app bell covers it
      for (final c in s.docChanges) {
        if (c.type == DocumentChangeType.removed) continue;
        final d = c.doc.data();
        if (d == null || d['unread'] != true || !_wants(d['type'] as String?)) continue;
        _show(d['title'] as String? ?? 'MindNest', d['body'] as String? ?? '');
      }
    }, onError: (_) {});
  }

  bool _wants(String? type) {
    final p = _settings.state;
    return switch (type) {
      'message' => p.messageAlerts,
      'booking' => p.sessionReminders,
      'content' => p.contentUpdates,
      'mood' => p.dailyReminders,
      _ => true,
    };
  }

  Future<void> _show(String title, String body) => _local.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000 % 0x7fffffff,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(android: _channel, iOS: DarwinNotificationDetails()),
      );

  void _openInbox() {
    if (_auth.currentUser == null) return;
    _router.push(const NotificationsRoute());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => _lifecycle = state;

  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSub?.cancel();
    _tokenSub?.cancel();
    _inboxSub?.cancel();
  }
}
