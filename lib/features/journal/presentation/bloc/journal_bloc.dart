import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/load_status.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';

part 'journal_bloc.freezed.dart';

enum JournalView { list, calendar }

enum JournalFilter { all, favourites, drafts }

@freezed
sealed class JournalEvent with _$JournalEvent {
  const factory JournalEvent.load() = JournalLoad;
  const factory JournalEvent.viewChanged(JournalView view) = JournalViewChanged;
  const factory JournalEvent.filterChanged(JournalFilter filter) = JournalFilterChanged;
  const factory JournalEvent.monthChanged(int delta) = JournalMonthChanged;
  const factory JournalEvent.selected(String? id) = JournalSelected;
  const factory JournalEvent.composeToggled(bool composing) = JournalComposeToggled;
  const factory JournalEvent.saved(JournalEntry entry) = JournalSaved;
  const factory JournalEvent.deleted(String id) = JournalDeleted;
  const factory JournalEvent.favouriteToggled(String id) = JournalFavouriteToggled;
}

@freezed
abstract class JournalState with _$JournalState {
  const factory JournalState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<JournalEntry>[]) List<JournalEntry> entries,
    @Default(JournalView.list) JournalView view,
    @Default(JournalFilter.all) JournalFilter filter,
    required DateTime month,
    String? selectedId,
    @Default(false) bool composing,
    String? error,
  }) = _JournalState;

  const JournalState._();

  List<JournalEntry> get visible => switch (filter) {
        JournalFilter.all => entries,
        JournalFilter.favourites => entries.where((e) => e.favourite).toList(),
        JournalFilter.drafts => entries.where((e) => e.draft).toList(),
      };

  JournalEntry? get selected {
    for (final e in entries) {
      if (e.id == selectedId) return e;
    }
    return visible.isEmpty ? null : visible.first;
  }

  /// Mood per day-of-month for the calendar (latest entry wins).
  Map<int, JournalEntry> get byDay => {
        for (final e in entries.reversed)
          if (e.createdAt.year == month.year && e.createdAt.month == month.month) e.createdAt.day: e,
      };
}

@lazySingleton
class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc(this._get, this._save, this._delete)
      : super(JournalState(month: DateTime(DateTime.now().year, DateTime.now().month))) {
    on<JournalLoad>((e, emit) async {
      if (state.entries.isEmpty) emit(state.copyWith(status: LoadStatus.loading));
      final res = await _get(const NoParams());
      res.fold(
        (f) => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
        (list) => emit(state.copyWith(status: LoadStatus.success, entries: list)),
      );
    });
    on<JournalViewChanged>((e, emit) => emit(state.copyWith(view: e.view)));
    on<JournalFilterChanged>((e, emit) => emit(state.copyWith(filter: e.filter)));
    on<JournalMonthChanged>(
      (e, emit) => emit(state.copyWith(month: DateTime(state.month.year, state.month.month + e.delta))),
    );
    on<JournalSelected>((e, emit) => emit(state.copyWith(selectedId: e.id, composing: false)));
    on<JournalComposeToggled>((e, emit) => emit(state.copyWith(composing: e.composing)));
    on<JournalSaved>((e, emit) {
      final exists = state.entries.any((x) => x.id == e.entry.id);
      final list = exists
          ? [for (final x in state.entries) x.id == e.entry.id ? e.entry : x]
          : [e.entry, ...state.entries];
      emit(state.copyWith(entries: list, selectedId: e.entry.id, composing: false));
    });
    on<JournalDeleted>((e, emit) async {
      emit(state.copyWith(entries: state.entries.where((x) => x.id != e.id).toList(), selectedId: null));
      await _delete(e.id);
    });
    on<JournalFavouriteToggled>((e, emit) async {
      final entry = state.entries.firstWhere((x) => x.id == e.id);
      final updated = entry.copyWith(favourite: !entry.favourite);
      emit(state.copyWith(entries: [for (final x in state.entries) x.id == e.id ? updated : x]));
      await _save(updated.copyWith(draft: entry.draft));
    });
  }

  final GetJournalEntries _get;
  final SaveJournalEntry _save;
  final DeleteJournalEntry _delete;
}
