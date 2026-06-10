import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/journal_entry.dart';
import '../repositories/journal_repository.dart';

@lazySingleton
class GetJournalEntries implements UseCase<List<JournalEntry>, NoParams> {
  GetJournalEntries(this._repo);
  final JournalRepository _repo;
  @override
  Future<Result<List<JournalEntry>>> call(NoParams params) =>
      _repo.getEntries();
}

@lazySingleton
class GetJournalEntry implements UseCase<JournalEntry, String> {
  GetJournalEntry(this._repo);
  final JournalRepository _repo;
  @override
  Future<Result<JournalEntry>> call(String id) => _repo.getEntry(id);
}

@lazySingleton
class SaveJournalEntry implements UseCase<Unit, JournalDraft> {
  SaveJournalEntry(this._repo);
  final JournalRepository _repo;
  @override
  Future<Result<Unit>> call(JournalDraft draft) => _repo.saveEntry(draft);
}
