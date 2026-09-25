import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../journal/data/datasources/journal_data_source.dart';
import '../../../sessions/data/datasources/sessions_data_source.dart';
import '../../../sessions/domain/entities/appointment.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/entities/mood_summary.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_data_source.dart';

/// Builds the mood summary from the user's check-ins. Days without a
/// check-in are `0` in the week/month series.
@LazySingleton(as: MoodRepository)
class MoodRepositoryImpl implements MoodRepository {
  const MoodRepositoryImpl(this._ds, this._journal, this._sessions);
  final MoodDataSource _ds;
  final JournalDataSource _journal;
  final SessionsDataSource _sessions;

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  ResultFuture<MoodSummary> getSummary() => guard(() async {
        final now = DateTime.now();
        final today = _day(now);
        final entries = (await _ds.entries(since: today.subtract(const Duration(days: 120))))
            .map((e) => e.toEntity())
            .toList();

        // Daily average level, rounded, keyed by day.
        final byDay = <DateTime, List<int>>{};
        for (final e in entries) {
          byDay.putIfAbsent(_day(e.createdAt), () => []).add(e.level);
        }
        final daily = {
          for (final e in byDay.entries) e.key: (e.value.reduce((a, b) => a + b) / e.value.length).round(),
        };
        List<int> series(int days) => [
              for (var i = days - 1; i >= 0; i--) daily[today.subtract(Duration(days: i))] ?? 0,
            ];
        final month = series(28);
        final week = month.sublist(21);
        final prevWeek = month.sublist(14, 21);

        double? avg(List<int> l) {
          final v = l.where((x) => x > 0).toList();
          return v.isEmpty ? null : v.reduce((a, b) => a + b) / v.length;
        }

        final wa = avg(week), pa = avg(prevWeek);
        final todays = entries.where((e) => _day(e.createdAt) == today);

        return MoodSummary(
          today: todays.isEmpty ? null : todays.first,
          week: week,
          month: month,
          streak: _currentStreak(byDay.keys.toSet(), today),
          bestStreak: _bestStreak(byDay.keys.toSet()),
          trendPercent: wa == null || pa == null ? 0 : ((wa - pa) / pa * 100).round(),
          recent: entries.take(10).toList(),
          insights: await _insights(daily),
        );
      });

  /// Consecutive days with a check-in, ending today (or yesterday if today
  /// hasn't been logged yet).
  int _currentStreak(Set<DateTime> days, DateTime today) {
    var d = days.contains(today) ? today : today.subtract(const Duration(days: 1));
    var n = 0;
    while (days.contains(d)) {
      n++;
      d = d.subtract(const Duration(days: 1));
    }
    return n;
  }

  int _bestStreak(Set<DateTime> days) {
    var best = 0;
    for (final d in days) {
      if (days.contains(d.subtract(const Duration(days: 1)))) continue;
      var n = 0;
      while (days.contains(d.add(Duration(days: n)))) {
        n++;
      }
      if (n > best) best = n;
    }
    return best;
  }

  Future<List<MoodInsight>> _insights(Map<DateTime, int> daily) async {
    if (daily.length < 5) {
      return const [
        MoodInsight(
          kind: InsightKind.journaling,
          title: 'Insights are on their way',
          body: 'Check in on a few more days and patterns in your mood will start to show here.',
        ),
      ];
    }
    final out = <MoodInsight>[];
    double mean(Iterable<int> l) => l.isEmpty ? 0 : l.reduce((a, b) => a + b) / l.length;

    // Journaling days vs. other days.
    final journalDays = {
      for (final j in await _journal.entries().catchError((_) => <Never>[])) _day(j.createdAt),
    };
    final withJ = daily.entries.where((e) => journalDays.contains(e.key)).map((e) => e.value);
    final withoutJ = daily.entries.where((e) => !journalDays.contains(e.key)).map((e) => e.value);
    if (withJ.length >= 2 && withoutJ.length >= 2) {
      final diff = mean(withJ) - mean(withoutJ);
      out.add(MoodInsight(
        kind: InsightKind.journaling,
        title: diff >= 0 ? 'Journaling lifts you' : 'Writing on harder days',
        body: diff >= 0
            ? 'On days you write an entry, your mood averages ${diff.toStringAsFixed(1)} points higher.'
            : 'You tend to journal on tougher days — a healthy way to process them.',
      ));
    }

    // Lowest weekday.
    const names = ['Mondays', 'Tuesdays', 'Wednesdays', 'Thursdays', 'Fridays', 'Saturdays', 'Sundays'];
    final byWeekday = <int, List<int>>{};
    for (final e in daily.entries) {
      byWeekday.putIfAbsent(e.key.weekday, () => []).add(e.value);
    }
    final ranked = byWeekday.entries.where((e) => e.value.length >= 2).toList()
      ..sort((a, b) => mean(a.value).compareTo(mean(b.value)));
    if (ranked.length >= 3 && mean(ranked.last.value) - mean(ranked.first.value) >= .5) {
      out.add(MoodInsight(
        kind: InsightKind.midweek,
        title: '${names[ranked.first.key - 1].replaceAll('s', '')} dips',
        body: '${names[ranked.first.key - 1]} tend to be your lowest — worth a gentler schedule if you can.',
      ));
    }

    // Mood in the 3 days after a session vs. overall.
    final sessionDays = [
      for (final a in await _sessions.appointments().catchError((_) => <Never>[]))
        if (a.status == AppointmentStatus.completed) _day(a.startsAt),
    ];
    final after = [
      for (final s in sessionDays)
        for (var i = 0; i <= 2; i++)
          ?daily[s.add(Duration(days: i))],
    ];
    if (after.length >= 3 && mean(after) > mean(daily.values)) {
      out.add(const MoodInsight(
        kind: InsightKind.sessions,
        title: 'Sessions help',
        body: 'Your mood rises for a couple of days after each therapy session.',
      ));
    }
    return out;
  }

  @override
  ResultFuture<MoodEntry> logMood({required int level, required List<String> factors, required String note}) =>
      guard(() async => (await _ds.log(level: level, factors: factors, note: note)).toEntity());
}
