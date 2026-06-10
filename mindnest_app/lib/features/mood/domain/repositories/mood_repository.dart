import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/mood.dart';

abstract interface class MoodRepository {
  Future<Result<MoodHistory>> getHistory();
  Future<Result<MoodInsights>> getInsights();
  Future<Result<List<int>>> getWeek();
  Future<Result<Unit>> logMood(MoodLog log);
}
