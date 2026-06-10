import 'package:equatable/equatable.dart';

class MoodEntry extends Equatable {
  const MoodEntry({
    required this.day,
    required this.time,
    required this.level,
    required this.note,
    required this.factors,
  });
  final String day, time, note;
  final int level;
  final List<String> factors;

  @override
  List<Object?> get props => [day, time, level, note, factors];
}

class MoodCount extends Equatable {
  const MoodCount(this.level, this.count);
  final int level, count;
  @override
  List<Object?> get props => [level, count];
}

class InsightCard extends Equatable {
  const InsightCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.topicIndex,
  });
  final String icon, title, body;
  final int topicIndex;
  @override
  List<Object?> get props => [icon, title, body, topicIndex];
}

class MoodHistory extends Equatable {
  const MoodHistory({
    required this.monthLevels,
    required this.average,
    required this.trendLabel,
    required this.recent,
  });
  final List<int> monthLevels;
  final int average;
  final String trendLabel;
  final List<MoodEntry> recent;
  @override
  List<Object?> get props => [monthLevels, average, trendLabel, recent];
}

class MoodInsights extends Equatable {
  const MoodInsights({
    required this.streakDays,
    required this.streakGoal,
    required this.average,
    required this.trendLabel,
    required this.week,
    required this.month,
    required this.distribution,
    required this.cards,
  });
  final int streakDays, streakGoal, average;
  final String trendLabel;
  final List<int> week, month;
  final List<MoodCount> distribution;
  final List<InsightCard> cards;
  @override
  List<Object?> get props => [
    streakDays,
    streakGoal,
    average,
    trendLabel,
    week,
    month,
    distribution,
    cards,
  ];
}

/// A mood check-in the user is logging.
class MoodLog extends Equatable {
  const MoodLog({
    required this.level,
    required this.factors,
    required this.note,
  });
  final int level;
  final List<String> factors;
  final String note;
  @override
  List<Object?> get props => [level, factors, note];
}
