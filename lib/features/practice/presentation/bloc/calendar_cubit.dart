import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';

part 'calendar_cubit.freezed.dart';

enum CalendarMode { day, week }

@freezed
abstract class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime weekStart,
    required DateTime selectedDay,
    @Default(CalendarMode.week) CalendarMode mode,
    @Default(<ScheduledSession>[]) List<ScheduledSession> sessions,
    @Default(false) bool loading,
  }) = _CalendarState;

  const CalendarState._();

  List<ScheduledSession> sessionsOn(DateTime d) => sessions
      .where((s) => s.startsAt.year == d.year && s.startsAt.month == d.month && s.startsAt.day == d.day)
      .toList()
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
}

DateTime _monday(DateTime d) {
  final day = DateTime(d.year, d.month, d.day);
  return day.subtract(Duration(days: day.weekday - 1));
}

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._week)
      : super(CalendarState(weekStart: _monday(DateTime.now()), selectedDay: DateTime.now()));

  final GetWeekSchedule _week;

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final r = await _week(state.weekStart);
    emit(state.copyWith(loading: false, sessions: r.getOrElse((_) => const [])));
  }

  Future<void> shiftWeek(int delta) async {
    final ws = state.weekStart.add(Duration(days: 7 * delta));
    emit(state.copyWith(weekStart: ws, selectedDay: ws));
    await load();
  }

  void setMode(CalendarMode m) => emit(state.copyWith(mode: m));
  void selectDay(DateTime d) => emit(state.copyWith(selectedDay: d));
}
