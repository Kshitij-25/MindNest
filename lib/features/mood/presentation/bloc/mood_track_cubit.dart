import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/mood_usecases.dart';
import 'mood_bloc.dart';

part 'mood_track_cubit.freezed.dart';

@freezed
abstract class MoodTrackState with _$MoodTrackState {
  const factory MoodTrackState({
    @Default(4) int level,
    @Default(<String>[]) List<String> factors,
    @Default('') String note,
    @Default(false) bool saving,
    @Default(false) bool saved,
  }) = _MoodTrackState;
}

@injectable
class MoodTrackCubit extends Cubit<MoodTrackState> {
  MoodTrackCubit(this._log, this._moodBloc) : super(const MoodTrackState());

  final LogMood _log;
  final MoodBloc _moodBloc;

  void setLevel(int v) => emit(state.copyWith(level: v));
  void setNote(String v) => emit(state.copyWith(note: v));
  void toggleFactor(String f) {
    final l = [...state.factors];
    l.contains(f) ? l.remove(f) : l.add(f);
    emit(state.copyWith(factors: l));
  }

  Future<void> save() async {
    emit(state.copyWith(saving: true));
    await _log(LogMoodParams(level: state.level, factors: state.factors, note: state.note));
    _moodBloc.add(const MoodEvent.refresh());
    emit(state.copyWith(saving: false, saved: true));
  }
}
