import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/journal_repository.dart';

@LazySingleton(as: JournalRepository)
class JournalRepositoryImpl implements JournalRepository {
  JournalRepositoryImpl();

  static String _s(Object? v, [String d = '']) => v is String ? v : d;

  JournalEntry _fromJson(Map<String, dynamic> j) => JournalEntry(
    id: _s(j['id']),
    day: _s(j['dayLabel'], _s(j['relativeTime'], 'Entry')),
    date: _s(j['dayLabel']),
    time: _s(j['clockLabel']),
    mood: j['mood'] is num ? (j['mood'] as num).toInt() : 3,
    title: _s(j['title']),
    body: _s(j['body']),
    tags: (j['tags'] as List?)?.cast<String>() ?? const [],
    draft: j['draft'] == true,
  );

  @override
  Future<Result<List<JournalEntry>>> getEntries() async {
    try {
      final raw = await wellnessApi.journalEntries();
      return Ok(raw.map(_fromJson).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<JournalEntry>> getEntry(String id) async {
    try {
      return Ok(_fromJson(await wellnessApi.journalEntry(id)));
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Unit>> saveEntry(JournalDraft draft) async {
    try {
      await wellnessApi.createJournal(
        title: draft.title,
        body: draft.body,
        mood: draft.mood,
        tags: draft.tags,
      );
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
