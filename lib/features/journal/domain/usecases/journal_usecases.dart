import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/journal_entry.dart';
import '../repositories/journal_repository.dart';

@injectable
class GetJournalEntries implements UseCase<List<JournalEntry>, NoParams> {
  const GetJournalEntries(this._repo);
  final JournalRepository _repo;

  @override
  ResultFuture<List<JournalEntry>> call(NoParams _) => _repo.getEntries();
}

@injectable
class SaveJournalEntry implements UseCase<JournalEntry, JournalEntry> {
  const SaveJournalEntry(this._repo);
  final JournalRepository _repo;

  @override
  ResultFuture<JournalEntry> call(JournalEntry e) async {
    if (e.body.trim().isEmpty && !e.draft) return const Left(ValidationFailure('Write a little before saving.'));
    return _repo.save(e);
  }
}

@injectable
class DeleteJournalEntry implements UseCase<void, String> {
  const DeleteJournalEntry(this._repo);
  final JournalRepository _repo;

  @override
  ResultFuture<void> call(String id) => _repo.delete(id);
}
