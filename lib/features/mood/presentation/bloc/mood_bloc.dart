import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/mood_summary.dart';
import '../../domain/usecases/mood_usecases.dart';

part 'mood_bloc.freezed.dart';

@freezed
sealed class MoodEvent with _$MoodEvent {
  const factory MoodEvent.load() = MoodLoad;
  const factory MoodEvent.quickLog(int level) = MoodQuickLog;
  const factory MoodEvent.refresh() = MoodRefresh;
}

@freezed
abstract class MoodState with _$MoodState {
  const factory MoodState({
    @Default(LoadStatus.initial) LoadStatus status,
    MoodSummary? summary,
    String? error,
    /// Set briefly after a quick log from the home check-in.
    int? justLogged,
  }) = _MoodState;
}

/// Shared mood state (home card, history, insights).
@lazySingleton
class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc(this._get, this._log) : super(const MoodState()) {
    on<MoodLoad>((e, emit) async {
      if (state.summary == null) emit(state.copyWith(status: LoadStatus.loading));
      await _fetch(emit);
    });
    on<MoodRefresh>((e, emit) => _fetch(emit));
    on<MoodQuickLog>((e, emit) async {
      emit(state.copyWith(justLogged: e.level));
      await _log(LogMoodParams(level: e.level));
      await _fetch(emit);
    });
  }

  final GetMoodSummary _get;
  final LogMood _log;

  Future<void> _fetch(Emitter<MoodState> emit) async {
    final res = await _get(const NoParams());
    res.fold(
      (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (s) => emit(state.copyWith(status: LoadStatus.success, summary: s)),
    );
  }
}
