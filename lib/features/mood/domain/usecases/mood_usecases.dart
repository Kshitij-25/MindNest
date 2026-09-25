import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/mood_entry.dart';
import '../entities/mood_summary.dart';
import '../repositories/mood_repository.dart';

@injectable
class GetMoodSummary implements UseCase<MoodSummary, NoParams> {
  const GetMoodSummary(this._repo);
  final MoodRepository _repo;

  @override
  ResultFuture<MoodSummary> call(NoParams _) => _repo.getSummary();
}

class LogMoodParams extends Equatable {
  const LogMoodParams({required this.level, this.factors = const [], this.note = ''});
  final int level;
  final List<String> factors;
  final String note;

  @override
  List<Object?> get props => [level, factors, note];
}

@injectable
class LogMood implements UseCase<MoodEntry, LogMoodParams> {
  const LogMood(this._repo);
  final MoodRepository _repo;

  @override
  ResultFuture<MoodEntry> call(LogMoodParams p) =>
      _repo.logMood(level: p.level.clamp(1, 5), factors: p.factors, note: p.note.trim());
}
