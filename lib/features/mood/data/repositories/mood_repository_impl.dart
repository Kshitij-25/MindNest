import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/entities/mood_summary.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_mock_data_source.dart';

@LazySingleton(as: MoodRepository)
class MoodRepositoryImpl implements MoodRepository {
  const MoodRepositoryImpl(this._ds);
  final MoodDataSource _ds;

  @override
  ResultFuture<MoodSummary> getSummary() => guard(() async {
        final entries = (await _ds.entries()).map((e) => e.toEntity()).toList();
        final month = await _ds.dailyLevels(28);
        final week = month.sublist(21);
        final now = DateTime.now();
        final today = entries.where((e) =>
            e.createdAt.year == now.year && e.createdAt.month == now.month && e.createdAt.day == now.day);
        final prevWeek = month.sublist(14, 21);
        double avg(List<int> l) => l.reduce((a, b) => a + b) / l.length;
        final trend = ((avg(week) - avg(prevWeek)) / avg(prevWeek) * 100).round();
        return MoodSummary(
          today: today.isEmpty ? null : today.first,
          week: week,
          month: month,
          streak: 12,
          bestStreak: 14,
          trendPercent: trend == 0 ? 12 : trend,
          recent: entries.take(10).toList(),
          insights: const [
            MoodInsight(
              kind: InsightKind.journaling,
              title: 'Journaling lifts you',
              body: 'On days you write an entry, your mood averages a full point higher.',
            ),
            MoodInsight(
              kind: InsightKind.midweek,
              title: 'Midweek dips',
              body: 'Wednesdays tend to be your lowest — worth a gentler schedule if you can.',
            ),
            MoodInsight(
              kind: InsightKind.sessions,
              title: 'Sessions help',
              body: 'Your mood rises for 2–3 days after each therapy session.',
            ),
          ],
        );
      });

  @override
  ResultFuture<MoodEntry> logMood({required int level, required List<String> factors, required String note}) =>
      guard(() async => (await _ds.log(level: level, factors: factors, note: note)).toEntity());
}
