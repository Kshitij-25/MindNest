import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/professional.dart';
import '../../domain/usecases/professional_usecases.dart';

class ProDashboardState extends Equatable {
  const ProDashboardState({
    this.status = ViewStatus.initial,
    this.stats,
    this.sessions = const [],
    this.failure,
  });

  final ViewStatus status;
  final DashboardStats? stats;
  final List<ProSession> sessions;
  final Failure? failure;

  List<ProSession> get todaySessions =>
      sessions.where((s) => s.when.startsWith('Today')).toList();

  ProDashboardState copyWith({
    ViewStatus? status,
    DashboardStats? stats,
    List<ProSession>? sessions,
    Failure? failure,
  }) => ProDashboardState(
    status: status ?? this.status,
    stats: stats ?? this.stats,
    sessions: sessions ?? this.sessions,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, stats, sessions, failure];
}

@injectable
class ProDashboardCubit extends Cubit<ProDashboardState> {
  ProDashboardCubit(this._getStats, this._getSessions)
    : super(const ProDashboardState());
  final GetDashboardStats _getStats;
  final GetTodaySessions _getSessions;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final statsResult = await _getStats(const NoParams());
    final failure = statsResult.failureOrNull;
    if (failure != null) {
      emit(state.copyWith(status: ViewStatus.error, failure: failure));
      return;
    }
    final sessionsResult = await _getSessions(const NoParams());
    sessionsResult.fold(
      (f) => emit(state.copyWith(status: ViewStatus.error, failure: f)),
      (sessions) => emit(
        state.copyWith(
          status: ViewStatus.loaded,
          stats: statsResult.valueOrNull,
          sessions: sessions,
        ),
      ),
    );
  }
}
