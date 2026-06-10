import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/mood.dart';
import '../repositories/mood_repository.dart';

@lazySingleton
class GetMoodHistory implements UseCase<MoodHistory, NoParams> {
  GetMoodHistory(this._repo);
  final MoodRepository _repo;
  @override
  Future<Result<MoodHistory>> call(NoParams params) => _repo.getHistory();
}

@lazySingleton
class GetMoodInsights implements UseCase<MoodInsights, NoParams> {
  GetMoodInsights(this._repo);
  final MoodRepository _repo;
  @override
  Future<Result<MoodInsights>> call(NoParams params) => _repo.getInsights();
}

@lazySingleton
class GetWeekMood implements UseCase<List<int>, NoParams> {
  GetWeekMood(this._repo);
  final MoodRepository _repo;
  @override
  Future<Result<List<int>>> call(NoParams params) => _repo.getWeek();
}

@lazySingleton
class LogMood implements UseCase<Unit, MoodLog> {
  LogMood(this._repo);
  final MoodRepository _repo;
  @override
  Future<Result<Unit>> call(MoodLog log) => _repo.logMood(log);
}
