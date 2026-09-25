import 'package:freezed_annotation/freezed_annotation.dart';

import 'mood_entry.dart';

part 'mood_summary.freezed.dart';

/// Aggregated mood data powering home, history and insights.
@freezed
abstract class MoodSummary with _$MoodSummary {
  const factory MoodSummary({
    MoodEntry? today,
    /// Last 7 days, oldest first (level 1..5, 0 = no check-in).
    required List<int> week,
    /// Last 28 days, oldest first.
    required List<int> month,
    required int streak,
    required int bestStreak,
    /// Week-over-week change, e.g. 12 for +12%.
    required int trendPercent,
    required List<MoodEntry> recent,
    required List<MoodInsight> insights,
  }) = _MoodSummary;

  const MoodSummary._();

  /// Averages over logged days only (0 = no check-in).
  double get weekAverage => _avg(week);
  double get monthAverage => _avg(month);

  static double _avg(List<int> l) {
    final v = l.where((x) => x > 0).toList();
    return v.isEmpty ? 3 : v.reduce((a, b) => a + b) / v.length;
  }

  /// Count of days at each level, keyed 1..5.
  Map<int, int> get distribution => {for (var l = 5; l >= 1; l--) l: month.where((m) => m == l).length};
}

enum InsightKind { journaling, midweek, sessions }

@freezed
abstract class MoodInsight with _$MoodInsight {
  const factory MoodInsight({required InsightKind kind, required String title, required String body}) = _MoodInsight;
}
