import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/mood_summary.dart';

const _weekdayInitials = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

/// Initials for the last 7 days ending today.
List<String> lastSevenDayInitials() {
  final today = DateTime.now().weekday; // 1 = Mon
  return [for (var i = 6; i >= 0; i--) _weekdayInitials[(today - 1 - i) % 7]];
}

/// 7-day mood pill strip (`MoodStrip`).
class MoodStrip extends StatelessWidget {
  const MoodStrip({super.key, required this.levels});
  final List<int> levels;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final days = lastSevenDayInitials();
    return Semantics(
      label: 'Mood this week: ${levels.map(moodLabel).join(', ')}',
      excludeSemantics: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < levels.length; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 8, end: 8.0 + levels[i] * 9),
                    duration: const Duration(milliseconds: 400),
                    curve: MnMotion.easeOut,
                    builder: (context, h, _) => Container(
                      height: h,
                      decoration: BoxDecoration(
                        color: c.mood(levels[i]).withValues(alpha: i == levels.length - 1 ? 1 : .85),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(days[i], style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Weekly mood bars coloured by level (insights).
class MoodWeekBars extends StatelessWidget {
  const MoodWeekBars({super.key, required this.levels, this.height = 130});
  final List<int> levels;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final days = lastSevenDayInitials();
    return MnBarChart(
      height: height,
      max: 5,
      data: [
        for (var i = 0; i < levels.length; i++) ChartBar(days[i], levels[i].toDouble(), color: c.mood(levels[i])),
      ],
      valueLabel: (v) => moodLabel(v.round()),
    );
  }
}

/// Flame streak ring.
class StreakRing extends StatelessWidget {
  const StreakRing({super.key, required this.streak, required this.best, this.size = 76});
  final int streak;
  final int best;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnDonut(
      value: best == 0 ? 0 : streak / best * 100,
      size: size,
      stroke: 6,
      color: c.streak,
      child: MnIcon(MnIcons.flame, size: size * .4, color: c.streak, stroke: 1.7),
    );
  }
}

/// Up/down trend chip.
class TrendChip extends StatelessWidget {
  const TrendChip({super.key, required this.percent});
  final int percent;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final up = percent >= 0;
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.hairline2, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.flip(flipY: !up, child: MnIcon(MnIcons.trend, size: 15, color: up ? c.green : c.red)),
          const SizedBox(width: 5),
          Text('${up ? '+' : ''}$percent%', style: context.text.sub.copyWith(fontWeight: FontWeight.w600, color: c.ink2)),
        ],
      ),
    );
  }
}

Color insightColor(BuildContext context, InsightKind k) {
  final t = context.colors.topics;
  return switch (k) {
    InsightKind.journaling => t[3],
    InsightKind.midweek => t[2],
    InsightKind.sessions => t[4],
  };
}

MnIconData insightIcon(InsightKind k) => switch (k) {
      InsightKind.journaling => MnIcons.lightbulb,
      InsightKind.midweek => MnIcons.sleep,
      InsightKind.sessions => MnIcons.heart,
    };

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.insight});
  final MoodInsight insight;

  @override
  Widget build(BuildContext context) {
    final col = insightColor(context, insight.kind);
    return MnCard(
      style: MnCardStyle.flat,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(size: 40, radius: 12, color: col.withValues(alpha: .14), child: MnIcon(insightIcon(insight.kind), size: 20, color: col, stroke: 1.9)),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(insight.title, style: context.text.headline.copyWith(fontSize: 15)),
                const SizedBox(height: 3),
                Text(insight.body, style: context.text.callout.copyWith(color: context.colors.ink2, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
