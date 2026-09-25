import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_entry.freezed.dart';

const journalTags = ['Calm', 'Gratitude', 'Stress', 'Sleep', 'Growth', 'Therapy', 'Self-care', 'Anxiety'];

@freezed
abstract class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    required String id,
    @Default('') String title,
    @Default('') String body,
    @Default(4) int mood,
    @Default(<String>[]) List<String> tags,
    required DateTime createdAt,
    @Default(false) bool draft,
    @Default(false) bool favourite,
  }) = _JournalEntry;

  const JournalEntry._();

  int get wordCount => body.trim().isEmpty ? 0 : body.trim().split(RegExp(r'\s+')).length;
  String get displayTitle => title.isNotEmpty ? title : (draft ? 'Untitled entry' : 'Reflection');
}
