import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  const JournalEntry({
    required this.id,
    required this.day,
    required this.date,
    required this.time,
    required this.mood,
    required this.title,
    required this.body,
    required this.tags,
    required this.draft,
  });

  final String id, day, date, time, title, body;
  final int mood;
  final List<String> tags;
  final bool draft;

  String get displayTitle =>
      title.isNotEmpty ? title : (draft ? 'Untitled entry' : 'Reflection');

  @override
  List<Object?> get props => [id, title, body, mood, tags, draft];
}

/// A journal entry being written/edited.
class JournalDraft extends Equatable {
  const JournalDraft({
    this.id,
    required this.title,
    required this.body,
    required this.mood,
    required this.tags,
  });
  final String? id;
  final String title, body;
  final int mood;
  final List<String> tags;

  @override
  List<Object?> get props => [id, title, body, mood, tags];
}
