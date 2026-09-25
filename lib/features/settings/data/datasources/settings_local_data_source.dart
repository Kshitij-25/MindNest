import 'dart:convert';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/app_preferences.dart';

abstract interface class SettingsLocalDataSource {
  AppPreferences read();
  Future<void> write(AppPreferences prefs);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;

  static const _key = 'app_preferences_v1';

  @override
  AppPreferences read() {
    final raw = _prefs.getString(_key);
    if (raw == null) return const AppPreferences();
    try {
      final m = jsonDecode(raw) as Map<String, dynamic>;
      return AppPreferences(
        themeMode: ThemeMode.values.byName(m['themeMode'] as String? ?? 'system'),
        textScale: (m['textScale'] as num?)?.toDouble() ?? 1,
        reduceMotion: m['reduceMotion'] as bool? ?? false,
        highContrast: m['highContrast'] as bool? ?? false,
        dailyReminders: m['dailyReminders'] as bool? ?? true,
        sessionReminders: m['sessionReminders'] as bool? ?? true,
        messageAlerts: m['messageAlerts'] as bool? ?? true,
        contentUpdates: m['contentUpdates'] as bool? ?? false,
        faceIdLock: m['faceIdLock'] as bool? ?? true,
      );
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  Future<void> write(AppPreferences p) async {
    final ok = await _prefs.setString(
      _key,
      jsonEncode({
        'themeMode': p.themeMode.name,
        'textScale': p.textScale,
        'reduceMotion': p.reduceMotion,
        'highContrast': p.highContrast,
        'dailyReminders': p.dailyReminders,
        'sessionReminders': p.sessionReminders,
        'messageAlerts': p.messageAlerts,
        'contentUpdates': p.contentUpdates,
        'faceIdLock': p.faceIdLock,
      }),
    );
    if (!ok) throw const CacheException();
  }
}
