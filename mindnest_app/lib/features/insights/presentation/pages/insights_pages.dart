import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/common.dart';
import 'package:mindnest_app/core/widgets/controls.dart';
import 'package:mindnest_app/core/widgets/icon.dart';
import 'package:mindnest_app/core/widgets/nav.dart';
import 'package:mindnest_app/core/widgets/primitives.dart';
import 'package:mindnest_app/shared/sample/wellness_sample.dart';
import 'package:mindnest_app/core/navigation/screen_nav.dart';
import 'package:mindnest_app/core/widgets/loaded.dart';
import 'package:mindnest_app/core/widgets/scroll_page.dart';
import 'package:mindnest_app/core/widgets/wellness.dart';
import 'package:mindnest_app/shared/api/wellness_repo.dart';

TrendDir _dir(String s) => switch (s) {
  'down' => TrendDir.down,
  'flat' => TrendDir.flat,
  _ => TrendDir.up,
};

// ════════════════════ INSIGHTS HUB (discover) ════════════════════

class InsightsHubScreen extends StatelessWidget {
  const InsightsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MvpPage(
      title: 'Insights',
      children: [
        Text(
          'Everything your check-ins, journals and habits are telling us — in one place.',
          style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
        ),
        const SizedBox(height: 18),
        for (final card in hubCards) ...[
          MnCard(
            onTap: () => context.pushScreen(card.screen, card.params),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconTile(icon: card.icon, color: context.token(card.color), size: 48),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.kind.toUpperCase(),
                            style: MnText.cap.copyWith(
                              color: context.token(card.color),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(card.headline, style: MnText.headline),
                          const SizedBox(height: 3),
                          Text(card.sub, style: MnText.foot.copyWith(color: c.ink2)),
                        ],
                      ),
                    ),
                    MnIcon('chevR', size: 20, color: c.ink4),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

// ════════════════════ WELLNESS SCORE ════════════════════

class WellnessScoreScreen extends StatelessWidget {
  const WellnessScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<WellnessData>(
      fetch: wellnessRepo.wellnessScore,
      title: 'Wellness score',
      builder: (context, w) {
        final c = context.c;
        return MvpPage(
          title: 'Wellness score',
          children: [
            MnCard(
              padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              RadialScore(value: w.score.toDouble(), size: 172, stroke: 14, sub: 'of 100'),
              const SizedBox(height: 14),
              Text(w.band, style: MnText.title3),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  TrendPill(dir: _dir(w.trend), label: '+${w.weeklyChange} vs last week'),
                  Confidence(value: w.confidence),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MnCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('7-day trend', style: MnText.headline)),
                  Text('${w.spark.first} → ${w.spark.last}',
                      style: MnText.foot.copyWith(color: c.ink3)),
                ],
              ),
              const SizedBox(height: 14),
              Spark(data: w.spark, height: 64),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionHead('What’s shaping it'),
        MnCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (var i = 0; i < w.signals.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    border: i < w.signals.length - 1
                        ? Border(bottom: BorderSide(color: c.hairline, width: 0.5))
                        : null,
                  ),
                  child: Row(
                    children: [
                      IconTile(icon: w.signals[i].icon, color: c.primary, size: 40),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(w.signals[i].key,
                                      style: MnText.callout.copyWith(fontWeight: FontWeight.w600)),
                                ),
                                Text('${w.signals[i].weight} weight',
                                    style: MnText.cap.copyWith(color: c.ink3)),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 28,
                                  child: Text('${w.signals[i].value}',
                                      textAlign: TextAlign.right,
                                      style: MnText.foot.copyWith(fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            _Meter(value: w.signals[i].value, color: c.primary, height: 7),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MnCard(
          kind: MnCardKind.flat,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MnIcon('info', size: 18, color: c.ink3),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your score blends mood, stress, anxiety, motivation, burnout, sleep and habits. Confidence reflects how much recent data we had to work with.',
                  style: MnText.foot.copyWith(color: c.ink2, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
      },
    );
  }
}

/// Thin rounded progress meter.
class _Meter extends StatelessWidget {
  const _Meter({required this.value, required this.color, this.height = 8});
  final int value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Stack(
        children: [
          Container(height: height, color: c.fill2),
          FractionallySizedBox(
            widthFactor: (value / 100).clamp(0, 1),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════ EMOTIONAL PROFILE ════════════════════

class EmotionalProfileScreen extends StatelessWidget {
  const EmotionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<List<Emotion>>(
      fetch: wellnessRepo.emotionalProfile,
      title: 'Emotional profile',
      isEmpty: (l) => l.isEmpty,
      emptyTitle: 'No profile yet',
      emptyBody: 'Complete a check-in to build your emotional profile.',
      builder: (context, ems) {
        final c = context.c;
        return MvpPage(
          title: 'Emotional profile',
          children: [
            MnCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: _RadarPainter(
                        values: [for (final e in ems) e.value / 100],
                        line: c.primary,
                        fill: c.primary.withValues(alpha: 0.2),
                        grid: c.hairline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final e in ems)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: context.token(e.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(e.key.split(' ').first,
                                style: MnText.cap.copyWith(color: c.ink3)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SectionHead('Each dimension'),
            MnCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  for (final e in ems)
                    EmotionBar(
                      label: e.key,
                      value: e.value,
                      color: context.token(e.color),
                      trend: e.trend,
                      desc: e.desc,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.values,
    required this.line,
    required this.fill,
    required this.grid,
  });
  final List<double> values;
  final Color line, fill, grid;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 12;
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = grid;
    for (final f in [0.33, 0.66, 1.0]) {
      canvas.drawCircle(center, r * f, gridPaint);
    }
    final n = values.length;
    Offset pt(int i, double radius) {
      final ang = (-90 + i * (360 / n)) * math.pi / 180;
      return center + Offset(radius * math.cos(ang), radius * math.sin(ang));
    }

    final path = Path();
    for (var i = 0; i < n; i++) {
      final p = pt(i, r * values[i]);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = fill);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..color = line,
    );
    for (var i = 0; i < n; i++) {
      canvas.drawCircle(pt(i, r * values[i]), 3.2, Paint()..color = line);
    }
  }

  @override
  bool shouldRepaint(_RadarPainter old) => old.values != values;
}

// ════════════════════ ASSESSMENTS ════════════════════

class AssessmentsScreen extends StatelessWidget {
  const AssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<({List<Assessment> a, List<AssessmentHistory> h})>(
      fetch: () async => (
        a: await wellnessRepo.assessments(),
        h: await wellnessRepo
            .assessmentHistory()
            .catchError((_) => <AssessmentHistory>[]),
      ),
      title: 'Assessments',
      builder: (context, data) {
        final c = context.c;
        return MvpPage(
          title: 'Assessments',
          children: [
            MnCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const RadialScore(value: 40, size: 84, stroke: 9, label: '2/5'),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Adaptive check-ins', style: MnText.headline),
                    const SizedBox(height: 4),
                    Text(
                      'Questions adapt to your recent answers, so each one stays short and relevant.',
                      style: MnText.foot.copyWith(color: c.ink2, height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHead('Available now'),
        for (final a in data.a) ...[
          MnCard(
            onTap: () => context.pushScreen('questionnaire', {'assessment': a.id}),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconTile(icon: a.icon, color: context.token(a.color), size: 46),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(a.name, style: MnText.headline)),
                              if (a.done)
                                const Badge2('Done today', kind: BadgeKind.accept),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(a.sub, style: MnText.foot.copyWith(color: c.ink2)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Hairline(margin: EdgeInsets.fromLTRB(0, 13, 0, 11)),
                Row(
                  children: [
                    MnIcon('clock', size: 14, color: c.ink3),
                    const SizedBox(width: 5),
                    Text(a.freq, style: MnText.cap.copyWith(color: c.ink3)),
                    const SizedBox(width: 8),
                    Text('· ${a.items} items', style: MnText.cap.copyWith(color: c.ink3)),
                    const Spacer(),
                    Confidence(value: a.confidence, small: true),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 10),
        const SectionHead('History'),
        MnCard(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              for (var i = 0; i < data.h.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                  decoration: BoxDecoration(
                    border: i < data.h.length - 1
                        ? Border(bottom: BorderSide(color: c.hairline, width: 0.5))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.h[i].name,
                                style: MnText.callout.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 2),
                            Text(data.h[i].date,
                                style: MnText.cap.copyWith(color: c.ink3)),
                          ],
                        ),
                      ),
                      Chip2(data.h[i].score, outline: true, height: 26),
                      const SizedBox(width: 8),
                      TrendPill(
                        dir: _dir(data.h[i].delta),
                        label: '${data.h[i].confidence}%',
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
      },
    );
  }
}

// ════════════════════ EMOTIONAL TIMELINE ════════════════════

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<List<TimelineEvent>>(
      fetch: wellnessRepo.timeline,
      title: 'Emotional timeline',
      isEmpty: (l) => l.isEmpty,
      emptyTitle: 'No timeline yet',
      emptyBody: 'Your emotional timeline builds as you check in over time.',
      builder: (context, tls) {
        final c = context.c;
        return MvpPage(
          title: 'Emotional timeline',
          children: [
            Text(
              'How your emotions have shifted — and the drivers behind each change.',
              style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
            ),
            const SizedBox(height: 20),
            for (final t in tls)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: mix(c.surface, t.tone == 'good' ? c.green : c.clay, 0.16),
                        shape: BoxShape.circle,
                        border: Border.all(color: c.bg, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scaleY: t.dir == 'down' ? -1 : 1,
                        child: MnIcon('trend',
                            size: 15, color: t.tone == 'good' ? c.green : c.clay, stroke: 2.4),
                      ),
                    ),
                    Expanded(child: Container(width: 2, color: c.hairline)),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MnCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(t.period.toUpperCase(),
                                    style: MnText.cap.copyWith(
                                        color: c.ink3, letterSpacing: 0.5, fontWeight: FontWeight.w700)),
                              ),
                              Text(t.change,
                                  style: MnText.headline.copyWith(
                                      color: t.tone == 'good' ? c.green : c.clay)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(t.note, style: MnText.callout.copyWith(color: c.ink2, height: 1.5)),
                          const SizedBox(height: 12),
                          Text('MAIN DRIVERS',
                              style: MnText.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 7),
                          Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: [
                              for (final d in t.drivers)
                                Chip2(d, outline: true, height: 28),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        );
      },
    );
  }
}

// ════════════════════ PATTERN DETECTOR ════════════════════

class PatternsScreen extends StatelessWidget {
  const PatternsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<List<Pattern>>(
      fetch: wellnessRepo.patterns,
      title: 'Patterns',
      isEmpty: (l) => l.isEmpty,
      emptyTitle: 'No patterns yet',
      emptyBody: 'Patterns surface once we have more check-ins and journals.',
      builder: (context, pats) {
        final c = context.c;
        return MvpPage(
          title: 'Patterns',
          children: [
            Text(
              'Recurring connections we’ve noticed across your check-ins, journals and habits.',
              style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
            ),
            const SizedBox(height: 18),
            for (final p in pats) ...[
          MnCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTile(icon: p.icon, color: context.token(p.color), size: 46),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title, style: MnText.headline),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(p.strength,
                                  style: MnText.cap.copyWith(
                                      color: context.token(p.color), fontWeight: FontWeight.w700)),
                              const SizedBox(width: 8),
                              Confidence(value: p.confidence, small: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(p.detail, style: MnText.callout.copyWith(color: c.ink2, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
      },
    );
  }
}

// ════════════════════ MEMORY HIGHLIGHTS ════════════════════

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<List<MemoryHighlight>>(
      fetch: wellnessRepo.memory,
      title: 'Memory highlights',
      isEmpty: (l) => l.isEmpty,
      emptyTitle: 'No memories yet',
      emptyBody: 'Meaningful moments appear here as you journal.',
      builder: (context, mems) {
        final c = context.c;
        return MvpPage(
          title: 'Memory highlights',
          children: [
            Text(
              'Moments worth remembering — surfaced from your journals so your coach can hold the bigger picture.',
              style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
            ),
            const SizedBox(height: 18),
            for (final m in mems) ...[
          MnCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconTile(icon: m.icon, color: context.token(m.color), size: 40),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Text(m.kind.toUpperCase(),
                          style: MnText.cap.copyWith(
                              color: context.token(m.color),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4)),
                    ),
                    Text(m.date, style: MnText.cap.copyWith(color: c.ink3)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(m.title, style: MnText.serif(size: 18)),
                const SizedBox(height: 6),
                Text('“${m.snippet}”',
                    style: MnText.callout.copyWith(
                        color: c.ink2, height: 1.5, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
      },
    );
  }
}

// ════════════════════ HABITS ════════════════════

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});
  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final _done = <String>{};

  @override
  Widget build(BuildContext context) {
    return Loaded<List<Habit>>(
      fetch: wellnessRepo.habits,
      title: 'Habits',
      isEmpty: (l) => l.isEmpty,
      emptyIcon: 'repeat',
      emptyTitle: 'No habits yet',
      emptyBody: 'Add a habit to start tracking how it shapes your mood.',
      builder: (context, habits) {
        final c = context.c;
        final adh = habits.isEmpty
            ? 0
            : (habits.map((h) => h.completion).reduce((a, b) => a + b) /
                      habits.length)
                  .round();
        return MvpPage(
      title: 'Habits',
      right: NavBtn(icon: 'plus', onTap: () {}),
      children: [
        MnCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              RadialScore(value: adh.toDouble(), size: 84, stroke: 9, color: c.streak),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('This week’s adherence', style: MnText.headline),
                    const SizedBox(height: 4),
                    Text(
                      'You’ve kept up $adh% of your habits this week.',
                      style: MnText.foot.copyWith(color: c.ink2, height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        for (final h in habits) ...[
          MnCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconTile(icon: h.icon, color: context.token(h.color), size: 44),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(h.name, style: MnText.headline),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              MnIcon('flame', size: 13, color: c.streak, stroke: 2),
                              const SizedBox(width: 3),
                              Text('${h.streak}-day streak',
                                  style: MnText.cap.copyWith(
                                      color: c.streak, fontWeight: FontWeight.w700)),
                              const SizedBox(width: 7),
                              Text('· ${h.completion}% complete',
                                  style: MnText.cap.copyWith(color: c.ink3)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _HabitCheck(
                      done: _done.contains(h.id),
                      color: context.token(h.color),
                      onTap: () => setState(() => _done.contains(h.id)
                          ? _done.remove(h.id)
                          : _done.add(h.id)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                WeekDots(week: h.week, color: context.token(h.color)),
                const SizedBox(height: 14),
                MnCard(
                  kind: MnCardKind.inset,
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    children: [
                      MnIcon('sparkle', size: 15, color: context.token(h.color)),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(h.correlation,
                            style: MnText.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
      },
    );
  }
}

class _HabitCheck extends StatelessWidget {
  const _HabitCheck({required this.done, required this.color, required this.onTap});
  final bool done;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: done ? color : Colors.transparent,
          shape: BoxShape.circle,
          border: done ? null : Border.all(color: c.hairline2, width: 2),
        ),
        child: MnIcon('check', size: 20, color: done ? Colors.white : c.ink4, stroke: 2.6),
      ),
    );
  }
}

// ════════════════════ WEEKLY REPORT ════════════════════

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Loaded<WeeklyReport>(
      fetch: wellnessRepo.weeklyReportData,
      title: 'Weekly report',
      builder: (context, r) {
        final c = context.c;
        return MvpPage(
      title: 'Weekly report',
      transparent: true,
      background: c.bg,
      right: NavBtn(icon: 'share', iconSize: 18, stroke: 1.9, onTap: () {}),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
      children: [
        Container(
          decoration: mvpTopGlow(context),
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Text('YOUR WEEK',
                  style: MnText.cap.copyWith(
                      color: c.ink3, letterSpacing: 0.7, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(r.range, style: MnText.serif(size: 30)),
              const SizedBox(height: 12),
              TrendPill(dir: TrendDir.up, label: 'Mood ${r.moodChange}'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        // mood summary
        MnCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  MoodFace(level: r.moodAvgLevel, size: 56),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AVERAGE MOOD', style: MnText.cap.copyWith(color: c.ink3)),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(r.moodAvg, style: MnText.title3),
                            const SizedBox(width: 6),
                            Text(r.moodChange,
                                style: MnText.foot.copyWith(color: c.green, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _MiniStat(label: 'Best day', value: r.best, color: c.green)),
                  const SizedBox(width: 10),
                  Expanded(child: _MiniStat(label: 'Hardest day', value: r.hardest, color: c.clay)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _RepCard(
          title: 'Emotional changes',
          child: Column(
            children: [
              for (final e in r.emotionalChanges)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(e.key, style: MnText.callout.copyWith(fontWeight: FontWeight.w600)),
                      ),
                      _DivergingBar(delta: e.delta),
                      SizedBox(
                        width: 36,
                        child: Text('${e.delta > 0 ? '+' : ''}${e.delta}',
                            textAlign: TextAlign.right,
                            style: MnText.foot.copyWith(
                                fontWeight: FontWeight.w700,
                                color: e.delta < 0 ? c.green : c.clay)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        _RepCard(
          title: 'Top topics',
          child: Column(
            children: [
              for (final t in r.topTopics)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 96,
                        child: Text(t.topic, style: MnText.callout.copyWith(fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: _Meter(
                          value: ((t.count / r.topTopics.first.count) * 100).round(),
                          color: c.primary,
                          height: 10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 22,
                        child: Text('${t.count}',
                            textAlign: TextAlign.right,
                            style: MnText.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: _AdherenceCard(label: 'Habit adherence', value: r.habitAdherence, color: c.streak)),
            const SizedBox(width: 12),
            Expanded(child: _AdherenceCard(label: 'Rec follow-through', value: r.recFollowThrough, color: c.primary)),
          ],
        ),
        const SizedBox(height: 14),
        _RepCard(
          title: 'Burnout movement',
          child: Row(
            children: [
              IconTile(icon: 'flame', color: c.green, size: 46),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${r.burnoutMovement}%', style: MnText.title3.copyWith(color: c.green)),
                    Text('Burnout risk eased this week — protecting your evenings helped.',
                        style: MnText.foot.copyWith(color: c.ink2)),
                  ],
                ),
              ),
            ],
          ),
        ),
        _RepCard(
          title: 'Patterns this week',
          child: Column(
            children: [
              for (final p in r.patternsList) _Bullet(icon: 'checkCircle', color: c.primary, text: p),
            ],
          ),
        ),
        _RepCard(
          title: 'Growth areas',
          child: Column(
            children: [
              for (final g in r.growthAreas) _Bullet(icon: 'trend', color: c.topic[3], text: g),
            ],
          ),
        ),
        MnCard(
          color: c.primaryTint,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              IconTile(icon: 'target', color: c.primary, size: 46),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SUGGESTED FOCUS', style: MnText.cap.copyWith(color: c.ink3)),
                    const SizedBox(height: 3),
                    Text(r.suggestedFocus, style: MnText.headline),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
      },
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.color});
  final String label, value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      kind: MnCardKind.inset,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MnText.cap.copyWith(color: c.ink3)),
          const SizedBox(height: 2),
          Text(value, style: MnText.headline.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _AdherenceCard extends StatelessWidget {
  const _AdherenceCard({required this.label, required this.value, required this.color});
  final String label;
  final int value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          RadialScore(value: value.toDouble(), size: 76, stroke: 8, color: color),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: MnText.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _DivergingBar extends StatelessWidget {
  const _DivergingBar({required this.delta});
  final int delta;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final frac = (delta.abs() * 3).clamp(0, 50) / 100;
    return SizedBox(
      width: 100,
      height: 7,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: c.fill2,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Align(
            alignment: delta < 0 ? Alignment.centerRight : Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              alignment: delta < 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Align(
                alignment: delta < 0 ? Alignment.centerRight : Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: (frac / 0.5).clamp(0, 1),
                  child: Container(
                    color: delta < 0 ? c.green : c.clay,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.icon, required this.color, required this.text});
  final String icon, text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          MnIcon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: MnText.callout.copyWith(color: c.ink2))),
        ],
      ),
    );
  }
}

class _RepCard extends StatelessWidget {
  const _RepCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: MnCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: MnText.headline),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

// ════════════════════ ANALYTICS ════════════════════

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _range = '30d';
  WellnessData? _score;
  List<Pattern> _patterns = const [];
  List<Habit> _habits = const [];
  WeeklyReport? _report;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final s = await wellnessRepo.wellnessScore();
      if (mounted) setState(() => _score = s);
    } catch (_) {}
    try {
      final p = await wellnessRepo.patterns();
      if (mounted) setState(() => _patterns = p);
    } catch (_) {}
    try {
      final h = await wellnessRepo.habits();
      if (mounted) setState(() => _habits = h);
    } catch (_) {}
    try {
      final r = await wellnessRepo.weeklyReportData();
      if (mounted) setState(() => _report = r);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MvpPage(
      title: 'Analytics',
      children: [
        Segmented(
          options: const ['7d', '30d', '90d'],
          value: _range,
          onChanged: (v) => setState(() => _range = v),
        ),
        const SizedBox(height: 16),
        if (_score != null)
          MnCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                RadialScore(value: _score!.score.toDouble(), size: 92, stroke: 9, sub: 'score'),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WELLNESS SCORE', style: MnText.cap.copyWith(color: c.ink3)),
                      const SizedBox(height: 2),
                      Text(_score!.band, style: MnText.title2),
                      const SizedBox(height: 8),
                      TrendPill(dir: TrendDir.up, label: '+${_score!.weeklyChange} this week'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),
        const _AnalyticCard(
          title: 'Mood trend',
          trend: TrendPill(dir: TrendDir.up, label: '+8%'),
          child: Spark(data: [3.2, 3.5, 3.1, 3.8, 4.0, 3.7, 4.1, 3.9, 4.2], height: 60),
        ),
        Row(
          children: [
            Expanded(
              child: MnCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Stress', style: MnText.foot.copyWith(fontWeight: FontWeight.w700))),
                        const TrendPill(dir: TrendDir.down, label: '−9%', invert: true),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Spark(data: const [62, 58, 65, 54, 60, 52, 56, 49, 54], color: c.topic[1], height: 48, fill: false),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MnCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Burnout', style: MnText.foot.copyWith(fontWeight: FontWeight.w700))),
                        const TrendPill(dir: TrendDir.down, label: '−12%', invert: true),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Spark(data: const [44, 46, 42, 40, 43, 38, 39, 36, 38], color: c.streak, height: 48, fill: false),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _AnalyticCard(
          title: 'Topic analysis',
          child: Column(
            children: [
              for (final t in (_report?.topTopics ?? const <TopTopic>[]))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(width: 96, child: Text(t.topic, style: MnText.callout.copyWith(fontWeight: FontWeight.w600))),
                      Expanded(
                        child: _Meter(
                          value: ((t.count / (_report?.topTopics.first.count ?? 1)) * 100).round(),
                          color: c.topic[0],
                          height: 9,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(width: 22, child: Text('${t.count}', textAlign: TextAlign.right, style: MnText.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SectionHead('Patterns', action: 'See all', onAction: () => context.pushScreen('patterns')),
        for (final p in _patterns.take(2)) ...[
          MnCard(
            kind: MnCardKind.flat,
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                IconTile(icon: p.icon, color: context.token(p.color), size: 40),
                const SizedBox(width: 12),
                Expanded(child: Text(p.title, style: MnText.callout.copyWith(fontWeight: FontWeight.w600, color: c.ink2))),
                Confidence(value: p.confidence, small: true),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        _AnalyticCard(
          title: 'Habit adherence',
          child: Column(
            children: [
              for (final h in _habits.take(4))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      SizedBox(width: 96, child: Text(h.name, style: MnText.callout.copyWith(fontWeight: FontWeight.w600))),
                      Expanded(child: _Meter(value: h.completion, color: context.token(h.color), height: 9)),
                      const SizedBox(width: 12),
                      SizedBox(width: 36, child: Text('${h.completion}%', textAlign: TextAlign.right, style: MnText.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        MnCard(
          onTap: () => context.pushScreen('weeklyReport'),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconTile(icon: 'doc', color: c.primary, size: 46),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Weekly wellness report', style: MnText.headline),
                    const SizedBox(height: 2),
                    Text(
                        'Recommendation follow-through: ${_report?.recFollowThrough ?? 0}%',
                        style: MnText.foot.copyWith(color: c.ink2)),
                  ],
                ),
              ),
              MnIcon('chevR', size: 20, color: c.ink4),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnalyticCard extends StatelessWidget {
  const _AnalyticCard({required this.title, required this.child, this.trend});
  final String title;
  final Widget child;
  final Widget? trend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: MnCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: MnText.headline)),
                ?trend,
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// ════════════════════ INSIGHT DETAIL ════════════════════

class InsightDetailScreen extends StatelessWidget {
  const InsightDetailScreen({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Loaded<InsightDetail>(
      fetch: () => wellnessRepo.insightDetail(type),
      title: 'Insight',
      builder: (context, d) {
        final c = context.c;
        return MvpPage(
      title: d.kind,
      right: NavBtn(icon: 'share', iconSize: 18, stroke: 1.9, onTap: () {}),
      padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
      children: [
        MnCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconTile(icon: d.icon, color: context.token(d.color), size: 56, radius: 16),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.headline, style: MnText.title3),
                        const SizedBox(height: 8),
                        Confidence(value: d.confidence),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MnCard(
                kind: MnCardKind.inset,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.metricLabel.toUpperCase(),
                                  style: MnText.cap.copyWith(color: c.ink3)),
                              const SizedBox(height: 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text('${d.metric}', style: MnText.title1),
                                  const SizedBox(width: 8),
                                  Text('${d.metricDelta}%',
                                      style: MnText.foot.copyWith(
                                          color: c.green, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Chip2(d.band, outline: true, height: 28),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Spark(data: d.spark, color: context.token(d.color), height: 56),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionHead('Contributing factors'),
        MnCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (final f in d.factors)
                EmotionBar(label: f.k, value: f.v, color: context.token(f.c)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SectionHead('Historical context'),
        Text(d.context, style: MnText.body.copyWith(color: c.ink2, height: 1.55)),
        const SizedBox(height: 16),
        const SectionHead('Recommendations'),
        for (final id in d.recs) ...[
          MnCard(
            kind: MnCardKind.flat,
            onTap: () => context.pushScreen('recDetail', {'id': id}),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                IconTile(icon: 'feather', color: c.primary, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('View a recommendation for this',
                      style: MnText.callout.copyWith(fontWeight: FontWeight.w600)),
                ),
                MnIcon('chevR', size: 18, color: c.ink4),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
      },
    );
  }
}
