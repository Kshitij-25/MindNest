import 'package:flutter/material.dart' show ThemeMode;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_preferences.freezed.dart';

/// User-controlled appearance, accessibility and notification preferences.
@freezed
abstract class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    @Default(ThemeMode.system) ThemeMode themeMode,
    /// Dynamic type multiplier on top of the OS setting (0.85 – 1.3).
    @Default(1.0) double textScale,
    @Default(false) bool reduceMotion,
    @Default(false) bool highContrast,
    @Default(true) bool dailyReminders,
    @Default(true) bool sessionReminders,
    @Default(true) bool messageAlerts,
    @Default(false) bool contentUpdates,
    @Default(true) bool faceIdLock,
  }) = _AppPreferences;
}
