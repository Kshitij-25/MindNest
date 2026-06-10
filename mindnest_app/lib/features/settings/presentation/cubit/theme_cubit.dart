import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/services/key_value_storage.dart';

/// App-wide light/dark theme state, persisted via [KeyValueStorage].
@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(_initial(_storage));
  final KeyValueStorage _storage;

  static const _key = 'theme_mode';

  static ThemeMode _initial(KeyValueStorage storage) =>
      storage.getString(_key) == 'dark' ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => state == ThemeMode.dark;

  void toggle() => setDark(state != ThemeMode.dark);

  void setDark(bool dark) {
    final mode = dark ? ThemeMode.dark : ThemeMode.light;
    _storage.setString(_key, dark ? 'dark' : 'light');
    emit(mode);
  }
}
