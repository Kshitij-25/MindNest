import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/tokens.dart';

/// Wellness model types + the design-token color resolver. These are the
/// shapes the backend maps onto (see `shared/api/wellness_repo.dart`). No
/// sample data lives here — only types and pure UI scaffolding.

/// Resolves a design token key (e.g. `topic-2`, `primary`, `mood-4`) to the
/// active palette color. Backend payloads carry token keys verbatim.
Color mvpColor(MnColors c, String key) {
  switch (key) {
    case 'primary':
      return c.primary;
    case 'clay':
      return c.clay;
    case 'green':
      return c.green;
    case 'amber':
      return c.amber;
    case 'red':
      return c.red;
    case 'blue':
      return c.blue;
    case 'streak':
      return c.streak;
    case 'paper':
      return c.paper;
    case 'ink-3':
      return c.ink3;
  }
  if (key.startsWith('moss-')) {
    return switch (key) {
      'moss-50' => c.moss50,
      'moss-100' => c.moss100,
      'moss-200' => c.moss200,
      'moss-300' => c.moss300,
      'moss-400' => c.moss400,
      'moss-500' => c.moss500,
      'moss-600' => c.moss600,
      'moss-700' => c.moss700,
      _ => c.moss800,
    };
  }
  if (key.startsWith('mood-')) {
    return c.mood[(int.tryParse(key.substring(5)) ?? 1) - 1];
  }
  if (key.startsWith('topic-')) {
    return c.topic[(int.tryParse(key.substring(6)) ?? 1) - 1];
  }
  return c.primary;
}

/// Convenience on context.
extension MvpColorX on BuildContext {
  Color token(String key) => mvpColor(c, key);
}

// ───────────────────────── Wellness score ─────────────────────────

class WellnessSignal {
  const WellnessSignal(this.key, this.value, this.weight, this.icon);
  final String key;
  final int value;
  final String weight;
  final String icon;
}

class WellnessData {
  const WellnessData({
    required this.score,
    required this.trend,
    required this.weeklyChange,
    required this.confidence,
    required this.band,
    required this.signals,
    required this.spark,
  });
  final int score;
  final String trend; // up | down | flat
  final int weeklyChange;
  final int confidence;
  final String band;
  final List<WellnessSignal> signals;
  final List<int> spark;
}

// ───────────────────────── Emotional profile ─────────────────────────

class Emotion {
  const Emotion(this.key, this.value, this.trend, this.color, this.desc);
  final String key;
  final int value;
  final int trend;
  final String color;
  final String desc;
}

// ───────────────────────── Assessments ─────────────────────────

class Assessment {
  const Assessment({
    required this.id,
    required this.name,
    required this.sub,
    required this.icon,
    required this.freq,
    required this.last,
    required this.confidence,
    required this.items,
    required this.done,
    required this.color,
  });
  final String id, name, sub, icon, freq, last, color;
  final int confidence, items;
  final bool done;
}

class AssessmentHistory {
  const AssessmentHistory(
    this.name,
    this.date,
    this.score,
    this.confidence,
    this.delta,
  );
  final String name, date, score, delta;
  final int confidence;
}

// ───────────────────────── Recommendations ─────────────────────────

class Rec {
  const Rec({
    required this.id,
    required this.kind,
    required this.icon,
    required this.color,
    required this.title,
    required this.reason,
    required this.benefit,
    required this.duration,
    required this.insight,
  });
  final String id, kind, icon, color, title, reason, benefit, duration, insight;
}

// ───────────────────────── Patterns ─────────────────────────

class Pattern {
  const Pattern(
    this.id,
    this.icon,
    this.color,
    this.title,
    this.detail,
    this.confidence,
    this.strength,
  );
  final String id, icon, color, title, detail, strength;
  final int confidence;
}

// ───────────────────────── Memory highlights ─────────────────────────

class MemoryHighlight {
  const MemoryHighlight(
    this.id,
    this.kind,
    this.icon,
    this.color,
    this.title,
    this.date,
    this.snippet,
  );
  final String id, kind, icon, color, title, date, snippet;
}

// ───────────────────────── Emotional timeline ─────────────────────────

class TimelineEvent {
  const TimelineEvent(
    this.id,
    this.period,
    this.change,
    this.dir,
    this.tone,
    this.drivers,
    this.note,
  );
  final String id, period, change, dir, tone, note;
  final List<String> drivers;
}

// ───────────────────────── Habits ─────────────────────────

class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.streak,
    required this.completion,
    required this.week,
    required this.correlation,
  });
  final String id, name, icon, color, correlation;
  final int streak, completion;
  final List<bool> week;
}

// ───────────────────────── Weekly report ─────────────────────────

class ReportDelta {
  const ReportDelta(this.key, this.delta);
  final String key;
  final int delta;
}

class TopTopic {
  const TopTopic(this.topic, this.count);
  final String topic;
  final int count;
}

class WeeklyReport {
  const WeeklyReport({
    required this.range,
    required this.moodAvg,
    required this.moodAvgLevel,
    required this.moodChange,
    required this.best,
    required this.hardest,
    required this.habitAdherence,
    required this.recFollowThrough,
    required this.burnoutMovement,
    required this.suggestedFocus,
    required this.emotionalChanges,
    required this.topTopics,
    required this.patternsList,
    required this.growthAreas,
  });

  final String range, moodAvg, moodChange, best, hardest, suggestedFocus;
  final int moodAvgLevel, habitAdherence, recFollowThrough, burnoutMovement;
  final List<ReportDelta> emotionalChanges;
  final List<TopTopic> topTopics;
  final List<String> patternsList, growthAreas;
}

// ───────────────────────── Insight detail ─────────────────────────

class InsightFactor {
  const InsightFactor(this.k, this.v, this.c);
  final String k;
  final int v;
  final String c;
}

class InsightDetail {
  const InsightDetail({
    required this.title,
    required this.kind,
    required this.icon,
    required this.color,
    required this.headline,
    required this.confidence,
    required this.band,
    required this.metric,
    required this.metricLabel,
    required this.metricDelta,
    required this.spark,
    required this.factors,
    required this.recs,
    required this.context,
  });
  final String title, kind, icon, color, headline, band, metricLabel, context;
  final int confidence, metric, metricDelta;
  final List<int> spark;
  final List<InsightFactor> factors;
  final List<String> recs;
}

// ───────────────────────── Insights hub (navigation config) ────────────────
// Static menu of insight destinations — UI scaffolding, not user data.

class HubCard {
  const HubCard(this.id, this.kind, this.icon, this.color, this.headline,
      this.sub, this.screen, this.params);
  final String id, kind, icon, color, headline, sub, screen;
  final Map<String, dynamic> params;
}

const hubCards = [
  HubCard('burnout', 'Burnout Analysis', 'flame', 'streak',
      'Burnout analysis', 'How your burnout signals are moving', 'insightDetail',
      {'type': 'burnout'}),
  HubCard('report', 'Weekly Wellness Report', 'doc', 'primary',
      'Your week, summarised', 'Mood, topics, habits & patterns', 'weeklyReport',
      {}),
  HubCard('patterns', 'Pattern Detection', 'pulse', 'topic-2',
      'Patterns', 'Recurring themes & triggers', 'patterns', {}),
  HubCard('timeline', 'Emotional Timeline', 'trend', 'topic-4',
      'Emotional timeline', 'What shifted, and why', 'timeline', {}),
  HubCard('memory', 'Memory Highlights', 'sparkle', 'topic-5',
      'Memory highlights', 'Moments worth keeping', 'memory', {}),
  HubCard('recs', 'Recommendations', 'feather', 'clay',
      'Recommendations', 'Personalised suggestions', 'recommendations', {}),
];
