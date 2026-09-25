import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/journal_data_source.dart';
import '../models/journal_entry_model.dart';

@LazySingleton(as: JournalRepository)
class JournalRepositoryImpl implements JournalRepository {
  const JournalRepositoryImpl(this._ds);
  final JournalDataSource _ds;

  @override
  ResultFuture<List<JournalEntry>> getEntries() =>
      guard(() async => (await _ds.entries()).map((e) => e.toEntity()).toList());

  @override
  ResultFuture<JournalEntry> save(JournalEntry entry) =>
      guard(() async => (await _ds.upsert(JournalEntryModel.fromEntity(entry))).toEntity());

  @override
  ResultFuture<void> delete(String id) => guard(() => _ds.delete(id));
}
