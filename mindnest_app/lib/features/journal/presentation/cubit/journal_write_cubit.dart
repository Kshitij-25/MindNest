import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/journal_usecases.dart';

class JournalWriteState extends Equatable {
  const JournalWriteState({
    this.mood = 4,
    this.tags = const {},
    this.words = 0,
    this.saved = false,
    this.id,
  });
  final int mood;
  final Set<String> tags;
  final int words;
  final bool saved;
  final String? id;

  JournalWriteState copyWith({
    int? mood,
    Set<String>? tags,
    int? words,
    bool? saved,
    String? id,
  }) => JournalWriteState(
    mood: mood ?? this.mood,
    tags: tags ?? this.tags,
    words: words ?? this.words,
    saved: saved ?? this.saved,
    id: id ?? this.id,
  );

  @override
  List<Object?> get props => [mood, tags, words, saved, id];
}

@injectable
class JournalWriteCubit extends Cubit<JournalWriteState> {
  JournalWriteCubit(this._saveEntry) : super(const JournalWriteState());
  final SaveJournalEntry _saveEntry;

  void init(JournalEntry? entry) {
    if (entry == null) return;
    emit(
      state.copyWith(id: entry.id, mood: entry.mood, tags: entry.tags.toSet()),
    );
  }

  void setMood(int mood) => emit(state.copyWith(mood: mood));

  void toggleTag(String tag) {
    final next = {...state.tags};
    next.contains(tag) ? next.remove(tag) : next.add(tag);
    emit(state.copyWith(tags: next));
  }

  void setWords(int words) => emit(state.copyWith(words: words));

  Future<void> save(String title, String body) async {
    await _saveEntry(
      JournalDraft(
        id: state.id,
        title: title,
        body: body,
        mood: state.mood,
        tags: state.tags.toList(),
      ),
    );
    emit(state.copyWith(saved: true));
  }
}
