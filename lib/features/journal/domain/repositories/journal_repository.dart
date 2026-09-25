import '../../../../core/usecase/usecase.dart';
import '../entities/journal_entry.dart';

abstract interface class JournalRepository {
  ResultFuture<List<JournalEntry>> getEntries();
  ResultFuture<JournalEntry> save(JournalEntry entry);
  ResultFuture<void> delete(String id);
}
