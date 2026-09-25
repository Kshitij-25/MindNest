import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/usecases/settings_usecases.dart';

/// App-wide preferences (theme, accessibility, notifications).
@lazySingleton
class SettingsCubit extends Cubit<AppPreferences> {
  SettingsCubit(this._load, this._save) : super(const AppPreferences());

  final LoadPreferences _load;
  final SavePreferences _save;

  Future<void> init() async {
    final res = await _load(const NoParams());
    res.fold((_) {}, emit);
  }

  void setThemeMode(ThemeMode mode) => _update(state.copyWith(themeMode: mode));

  /// Flips between light and dark, resolving `system` against [platformIsDark].
  void toggleTheme({required bool platformIsDark}) {
    final isDark = state.themeMode == ThemeMode.dark ||
        (state.themeMode == ThemeMode.system && platformIsDark);
    setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  void setTextScale(double v) => _update(state.copyWith(textScale: v.clamp(0.85, 1.3)));
  void setReduceMotion(bool v) => _update(state.copyWith(reduceMotion: v));
  void setHighContrast(bool v) => _update(state.copyWith(highContrast: v));
  void setDailyReminders(bool v) => _update(state.copyWith(dailyReminders: v));
  void setSessionReminders(bool v) => _update(state.copyWith(sessionReminders: v));
  void setMessageAlerts(bool v) => _update(state.copyWith(messageAlerts: v));
  void setContentUpdates(bool v) => _update(state.copyWith(contentUpdates: v));
  void setFaceIdLock(bool v) => _update(state.copyWith(faceIdLock: v));

  void _update(AppPreferences next) {
    emit(next);
    _save(next);
  }
}
