import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/entities/mood.dart';
import '../../domain/repositories/mood_repository.dart';

@LazySingleton(as: MoodRepository)
class MoodRepositoryImpl implements MoodRepository {
  MoodRepositoryImpl();

  static String _s(Object? v, [String d = '']) => v is String ? v : d;

  @override
  Future<Result<MoodHistory>> getHistory() async {
    try {
      final j = await wellnessApi.moodHistory();
      final recent =
          (j['recent'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
      return Ok(
        MoodHistory(
          monthLevels: (j['monthLevels'] as List?)?.cast<int>() ?? const [],
          average: ((j['average'] as num?) ?? 0).round(),
          trendLabel: _s(j['trendLabel']),
          recent: [
            for (final r in recent)
              MoodEntry(
                day: _s(r['dayLabel'], _s(r['relativeTime'])),
                time: _s(r['clockLabel']),
                level: (r['level'] as num?)?.toInt() ?? 3,
                note: _s(r['note']),
                factors: (r['factors'] as List?)?.cast<String>() ?? const [],
              ),
          ],
        ),
      );
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<MoodInsights>> getInsights() async {
    try {
      final j = await wellnessApi.moodInsights();
      final dist =
          (j['distribution'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
      final cards =
          (j['cards'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
      return Ok(
        MoodInsights(
          streakDays: (j['streakDays'] as num?)?.toInt() ?? 0,
          streakGoal: (j['streakGoal'] as num?)?.toInt() ?? 14,
          average: ((j['average'] as num?) ?? 0).round(),
          trendLabel: _s(j['trendLabel']),
          week: (j['week'] as List?)?.cast<int>() ?? const [],
          month: (j['month'] as List?)?.cast<int>() ?? const [],
          distribution: [
            for (final d in dist)
              MoodCount((d['level'] as num?)?.toInt() ?? 0,
                  (d['count'] as num?)?.toInt() ?? 0),
          ],
          cards: [
            for (final card in cards)
              InsightCard(
                icon: 'lightbulb',
                title: _s(card['title']),
                body: _s(card['body']),
                topicIndex: (card['topicIndex'] as num?)?.toInt() ?? 0,
              ),
          ],
        ),
      );
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<int>>> getWeek() async {
    try {
      final j = await wellnessApi.moodInsights();
      return Ok((j['week'] as List?)?.cast<int>() ?? const []);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  // The check-in itself is POSTed by MoodTrackCubit (POST /mood/checkin).
  @override
  Future<Result<Unit>> logMood(MoodLog log) async => const Ok(unit);
}
