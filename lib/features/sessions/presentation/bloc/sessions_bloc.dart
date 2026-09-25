import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/usecases/sessions_usecases.dart';

part 'sessions_bloc.freezed.dart';

@freezed
sealed class SessionsEvent with _$SessionsEvent {
  const factory SessionsEvent.load() = SessionsLoad;
  const factory SessionsEvent.cancelled(String id) = SessionsCancelled;
}

@freezed
abstract class SessionsState with _$SessionsState {
  const factory SessionsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<Appointment>[]) List<Appointment> upcoming,
    @Default(<Appointment>[]) List<Appointment> past,
    String? error,
  }) = _SessionsState;

  const SessionsState._();

  Appointment? get next => upcoming.isEmpty ? null : upcoming.first;
}

/// Shared by home (next session) and the sessions screen.
@lazySingleton
class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc(this._upcoming, this._past, this._cancel) : super(const SessionsState()) {
    on<SessionsLoad>((e, emit) async {
      if (state.upcoming.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
      final up = await _upcoming(const NoParams());
      final past = await _past(const NoParams());
      up.fold(
        (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
        (u) => emit(state.copyWith(
          status: LoadStatus.success,
          upcoming: u,
          past: past.getOrElse((_) => const []).where((a) => a.status == AppointmentStatus.completed).toList(),
        )),
      );
    });
    on<SessionsCancelled>((e, emit) async {
      emit(state.copyWith(upcoming: state.upcoming.where((a) => a.id != e.id).toList()));
      await _cancel(e.id);
    });
  }

  final GetUpcomingSessions _upcoming;
  final GetPastSessions _past;
  final CancelSession _cancel;
}
