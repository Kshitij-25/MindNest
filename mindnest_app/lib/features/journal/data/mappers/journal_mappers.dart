import '../../domain/entities/journal_entry.dart';
import '../models/journal_models.dart';

extension JournalEntryModelX on JournalEntryModel {
  JournalEntry toEntity() => JournalEntry(
    id: id,
    day: day,
    date: date,
    time: time,
    mood: mood,
    title: title,
    body: body,
    tags: tags,
    draft: draft,
  );
}
