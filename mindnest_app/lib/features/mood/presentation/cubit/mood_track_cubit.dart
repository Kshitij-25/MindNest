import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';

class MoodTrackState extends Equatable {
  const MoodTrackState({
    this.level = 4,
    this.factors = const {},
    this.saving = false,
    this.saved = false,
    this.error = false,
  });
  final int level;
  final Set<String> factors;
  final bool saving;
  final bool saved;
  final bool error;

  MoodTrackState copyWith({
    int? level,
    Set<String>? factors,
    bool? saving,
    bool? saved,
    bool? error,
  }) => MoodTrackState(
    level: level ?? this.level,
    factors: factors ?? this.factors,
    saving: saving ?? this.saving,
    saved: saved ?? this.saved,
    error: error ?? this.error,
  );

  @override
  List<Object?> get props => [level, factors, saving, saved, error];
}

@injectable
class MoodTrackCubit extends Cubit<MoodTrackState> {
  MoodTrackCubit() : super(const MoodTrackState());

  void setLevel(int level) => emit(state.copyWith(level: level));

  void toggleFactor(String factor) {
    final next = {...state.factors};
    next.contains(factor) ? next.remove(factor) : next.add(factor);
    emit(state.copyWith(factors: next));
  }

  /// Persist the check-in (POST /mood/checkin). Surfaces a real error state
  /// rather than faking success when the backend is unreachable.
  Future<void> save(String note) async {
    emit(state.copyWith(saving: true, error: false));
    try {
      await wellnessApi.moodCheckin(
        level: state.level,
        factors: state.factors.toList(),
        note: note,
      );
      emit(state.copyWith(saving: false, saved: true));
    } catch (_) {
      emit(state.copyWith(saving: false, error: true));
    }
  }
}
