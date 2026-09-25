import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';
import 'journal_bloc.dart';

part 'journal_editor_cubit.freezed.dart';

@freezed
abstract class JournalEditorState with _$JournalEditorState {
  const factory JournalEditorState({
    required JournalEntry entry,
    @Default(false) bool saving,
    @Default(false) bool saved,
    String? error,
  }) = _JournalEditorState;
}

@injectable
class JournalEditorCubit extends Cubit<JournalEditorState> {
  JournalEditorCubit(this._save, this._journal)
      : super(JournalEditorState(entry: JournalEntry(id: 'new', createdAt: DateTime.now())));

  final SaveJournalEntry _save;
  final JournalBloc _journal;

  void start(JournalEntry? existing) {
    emit(JournalEditorState(
      entry: existing ?? JournalEntry(id: 'j${DateTime.now().microsecondsSinceEpoch}', createdAt: DateTime.now()),
    ));
  }

  void setTitle(String v) => emit(state.copyWith(entry: state.entry.copyWith(title: v)));
  void setBody(String v) => emit(state.copyWith(entry: state.entry.copyWith(body: v)));
  void setMood(int v) => emit(state.copyWith(entry: state.entry.copyWith(mood: v)));
  void toggleTag(String t) {
    final tags = [...state.entry.tags];
    tags.contains(t) ? tags.remove(t) : tags.add(t);
    emit(state.copyWith(entry: state.entry.copyWith(tags: tags)));
  }

  Future<void> save() async {
    emit(state.copyWith(saving: true, error: null));
    final res = await _save(state.entry.copyWith(draft: false));
    res.fold(
      (f) => emit(state.copyWith(saving: false, error: f.message)),
      (e) {
        _journal.add(JournalEvent.saved(e));
        emit(state.copyWith(saving: false, saved: true, entry: e));
      },
    );
  }

  /// Persist as a draft when leaving with unsaved text.
  Future<void> saveDraft() async {
    if (state.saved || state.entry.body.trim().isEmpty) return;
    final res = await _save(state.entry.copyWith(draft: true));
    res.fold((_) {}, (e) => _journal.add(JournalEvent.saved(e)));
  }
}
