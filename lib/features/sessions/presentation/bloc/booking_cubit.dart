import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../../therapists/domain/entities/therapist.dart';
import '../../../therapists/domain/usecases/therapist_usecases.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/usecases/sessions_usecases.dart';
import 'sessions_bloc.dart';

part 'booking_cubit.freezed.dart';

@freezed
abstract class BookingState with _$BookingState {
  const factory BookingState({
    @Default(LoadStatus.initial) LoadStatus status,
    Therapist? therapist,
    @Default(<BookingDay>[]) List<BookingDay> days,
    @Default(0) int dayIndex,
    DateTime? slot,
    @Default(SessionType.video) SessionType type,
    @Default(Recurrence.oneTime) Recurrence recurrence,
    @Default(<Reminder>{Reminder.day, Reminder.hour}) Set<Reminder> reminders,
    @Default(false) bool submitting,
    Appointment? booked,
    String? error,
    String? rescheduleOf,
  }) = _BookingState;

  const BookingState._();

  BookingDay? get day => days.isEmpty ? null : days[dayIndex];
}

@injectable
class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._getTherapist, this._getDays, this._book, this._sessions) : super(const BookingState());

  final GetTherapist _getTherapist;
  final GetBookingDays _getDays;
  final BookSession _book;
  final SessionsBloc _sessions;

  Future<void> load(String therapistId, {String? rescheduleOf}) async {
    emit(state.copyWith(status: LoadStatus.loading, rescheduleOf: rescheduleOf));
    final t = await _getTherapist(therapistId);
    final d = await _getDays(therapistId);
    t.fold(
      (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (therapist) {
        final days = d.getOrElse((_) => const []);
        final first = days.indexWhere((x) => x.available);
        emit(state.copyWith(
          status: LoadStatus.success,
          therapist: therapist,
          days: days,
          dayIndex: first < 0 ? 0 : first,
          type: SessionType.values.firstWhere(
            (s) => therapist.sessionTypes.contains(s.label),
            orElse: () => SessionType.video,
          ),
        ));
      },
    );
  }

  void selectDay(int i) => emit(state.copyWith(dayIndex: i, slot: null));
  void selectSlot(DateTime t) => emit(state.copyWith(slot: t));
  void setType(SessionType t) => emit(state.copyWith(type: t));
  void setRecurrence(Recurrence r) => emit(state.copyWith(recurrence: r));
  void toggleReminder(Reminder r) {
    final s = {...state.reminders};
    s.contains(r) ? s.remove(r) : s.add(r);
    emit(state.copyWith(reminders: s));
  }

  Future<void> confirm() async {
    final t = state.therapist;
    final slot = state.slot;
    if (t == null || slot == null) return;
    emit(state.copyWith(submitting: true));
    final res = await _book(BookingRequest(
      therapistId: t.id,
      startsAt: slot,
      type: state.type,
      recurrence: state.recurrence,
      reminders: state.reminders,
      rescheduleOf: state.rescheduleOf,
    ));
    res.fold(
      (f) => emit(state.copyWith(submitting: false, error: f.message)),
      (a) {
        _sessions.add(const SessionsEvent.load());
        emit(state.copyWith(submitting: false, booked: a));
      },
    );
  }
}
