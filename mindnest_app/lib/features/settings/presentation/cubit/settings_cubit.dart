import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.push = true,
    this.reminders = true,
    this.emails = false,
    this.biometric = true,
    this.flags = const {},
  });

  final bool push;
  final bool reminders;
  final bool emails;
  final bool biometric;

  /// Server-side feature flags (camelCase keys) from GET /settings.
  final Map<String, bool> flags;

  SettingsState copyWith({
    bool? push,
    bool? reminders,
    bool? emails,
    bool? biometric,
    Map<String, bool>? flags,
  }) => SettingsState(
    push: push ?? this.push,
    reminders: reminders ?? this.reminders,
    emails: emails ?? this.emails,
    biometric: biometric ?? this.biometric,
    flags: flags ?? this.flags,
  );

  @override
  List<Object?> get props => [push, reminders, emails, biometric, flags];
}

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setPush(bool v) => emit(state.copyWith(push: v));

  void setReminders(bool v) => emit(state.copyWith(reminders: v));

  void setEmails(bool v) => emit(state.copyWith(emails: v));

  void setBiometric(bool v) => emit(state.copyWith(biometric: v));

  /// Load the server-side feature flags (best-effort).
  Future<void> load() async {
    try {
      final s = await wellnessApi.settings();
      final raw = (s['featureFlags'] as Map?)?.cast<String, dynamic>();
      if (raw != null) {
        emit(state.copyWith(
          flags: {for (final e in raw.entries) e.key: e.value == true},
        ));
      }
    } catch (_) {}
  }

  /// Toggle one feature flag and persist it (PATCH /settings).
  Future<void> setFlag(String key, bool value) async {
    final next = {...state.flags, key: value};
    emit(state.copyWith(flags: next)); // optimistic
    try {
      await wellnessApi.updateSettings(featureFlags: next);
    } catch (_) {
      // Leave the optimistic value; it re-syncs on next load.
    }
  }
}
