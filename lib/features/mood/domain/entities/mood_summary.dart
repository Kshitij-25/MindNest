import 'package:freezed_annotation/freezed_annotation.dart';

import 'mood_entry.dart';

part 'mood_summary.freezed.dart';

/// Aggregated mood data powering home, history and insights.
@freezed
abstract class MoodSummary with _$MoodSummary {
  const factory MoodSummary({
    MoodEntry? today,
    /// Last 7 days, oldest first (level 1..5).
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

  double get weekAverage => week.isEmpty ? 3 : week.reduce((a, b) => a + b) / week.length;
  double get monthAverage => month.isEmpty ? 3 : month.reduce((a, b) => a + b) / month.length;

  /// Count of days at each level, keyed 1..5.
  Map<int, int> get distribution => {for (var l = 5; l >= 1; l--) l: month.where((m) => m == l).length};
}

enum InsightKind { journaling, midweek, sessions }

@freezed
abstract class MoodInsight with _$MoodInsight {
  const factory MoodInsight({required InsightKind kind, required String title, required String body}) = _MoodInsight;
}
