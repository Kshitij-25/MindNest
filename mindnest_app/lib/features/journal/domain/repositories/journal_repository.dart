import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/journal_entry.dart';

abstract interface class JournalRepository {
  Future<Result<List<JournalEntry>>> getEntries();
  Future<Result<JournalEntry>> getEntry(String id);
  Future<Result<Unit>> saveEntry(JournalDraft draft);
}
