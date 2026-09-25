import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/event_transformers.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/therapist.dart';
import '../../domain/entities/therapist_filter.dart';
import '../../domain/usecases/therapist_usecases.dart';

part 'discover_bloc.freezed.dart';

@freezed
sealed class DiscoverEvent with _$DiscoverEvent {
  const factory DiscoverEvent.started() = DiscoverStarted;
  const factory DiscoverEvent.queryChanged(String query) = DiscoverQueryChanged;
  const factory DiscoverEvent.specialtySelected(String specialty) = DiscoverSpecialtySelected;
  const factory DiscoverEvent.filterApplied(TherapistFilter filter) = DiscoverFilterApplied;
  const factory DiscoverEvent.cleared() = DiscoverCleared;
  const factory DiscoverEvent.savedToggled(String id) = DiscoverSavedToggled;
}

@freezed
abstract class DiscoverState with _$DiscoverState {
  const factory DiscoverState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<Therapist>[]) List<Therapist> therapists,
    @Default(TherapistFilter()) TherapistFilter filter,
    String? error,
  }) = _DiscoverState;
}

@injectable
class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc(this._get, this._toggle) : super(const DiscoverState()) {
    on<DiscoverStarted>((e, emit) => _load(emit, state.filter), transformer: restartable());
    on<DiscoverQueryChanged>(
      (e, emit) => _load(emit, state.filter.copyWith(query: e.query)),
      transformer: debounceRestartable(),
    );
    on<DiscoverSpecialtySelected>((e, emit) => _load(emit, state.filter.copyWith(specialty: e.specialty)),
        transformer: restartable());
    on<DiscoverFilterApplied>((e, emit) => _load(emit, e.filter), transformer: restartable());
    on<DiscoverCleared>((e, emit) => _load(emit, const TherapistFilter()), transformer: restartable());
    on<DiscoverSavedToggled>((e, emit) async {
      emit(state.copyWith(
        therapists: [for (final t in state.therapists) t.id == e.id ? t.copyWith(saved: !t.saved) : t],
      ));
      await _toggle(e.id);
    });
  }

  final GetTherapists _get;
  final ToggleSavedTherapist _toggle;

  Future<void> _load(Emitter<DiscoverState> emit, TherapistFilter f) async {
    emit(state.copyWith(filter: f, status: state.therapists.isEmpty ? LoadStatus.loading : state.status));
    final res = await _get(f);
    res.fold(
      (fail) => emit(state.copyWith(status: LoadStatus.failure, error: fail.message)),
      (list) => emit(state.copyWith(status: LoadStatus.success, therapists: list)),
    );
  }
}
