import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

/// Sends FCM pushes straight from the app via the FCM HTTP v1 API.
///
/// ⚠ SECURITY TRADE-OFF (accepted by the project owner): this ships a
/// service-account private key inside the app, where it can be extracted.
/// Use a DEDICATED service account whose ONLY role is
/// "Firebase Cloud Messaging API Admin" — then a leaked key can send
/// notifications but can't read or change any data. Never use the
/// firebase-adminsdk key here. Move this to a server when you can.
///
/// Configure at build time with the downloaded key file itself:
///   flutter run --dart-define-from-file=fcm-sender.json
/// (fcm-sender.json is git-ignored). Without it, pushes are skipped and only
/// the in-app inbox is used.
///
/// Recipients are addressed by topic — `user_<uid>_<type>` — which each
/// device subscribes to according to its notification settings, so the
/// sender never needs the recipient's device tokens.
abstract final class PushSender {
  static const _projectId = String.fromEnvironment('project_id');
  static const _clientEmail = String.fromEnvironment('client_email');
  static const _clientId = String.fromEnvironment('client_id');
  static const _privateKey = String.fromEnvironment('private_key');
  static const _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  static bool get isConfigured => _projectId.isNotEmpty && _clientEmail.isNotEmpty && _privateKey.isNotEmpty;

  static String topic(String uid, String type) => 'user_${uid}_$type';

  static final _http = http.Client();
  static AccessCredentials? _creds;

  static Future<String> _token() async {
    final c = _creds;
    if (c != null && c.accessToken.expiry.isAfter(DateTime.now().toUtc().add(const Duration(minutes: 2)))) {
      return c.accessToken.data;
    }
    final account = ServiceAccountCredentials(_clientEmail, ClientId(_clientId), _privateKey);
    return (_creds = await obtainAccessCredentialsViaServiceAccount(account, _scopes, _http)).accessToken.data;
  }

  /// Best effort: failures are logged, never thrown — the inbox item has
  /// already been written.
  static Future<void> send({
    required String to,
    required String type,
    required String title,
    required String body,
    String? targetId,
  }) async {
    if (!isConfigured) return;
    try {
      final res = await _http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$_projectId/messages:send'),
        headers: {'Authorization': 'Bearer ${await _token()}', 'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': {
            'topic': topic(to, type),
            'notification': {'title': title, 'body': body},
            'data': {'type': type, 'targetId': targetId ?? ''},
            'android': {
              'priority': 'high',
              'notification': {'channel_id': 'mindnest_default'},
            },
            'apns': {
              'payload': {
                'aps': {'sound': 'default'},
              },
            },
          },
        }),
      );
      if (res.statusCode != 200) debugPrint('FCM send failed (${res.statusCode}): ${res.body}');
    } catch (e) {
      debugPrint('FCM send failed: $e');
    }
  }
}
