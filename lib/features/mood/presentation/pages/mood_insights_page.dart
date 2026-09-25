import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/mood_summary.dart';
import '../bloc/mood_bloc.dart';
import '../widgets/mood_widgets.dart';

enum _Range { week, month }

@RoutePage()
class MoodInsightsPage extends StatefulWidget {
  const MoodInsightsPage({super.key});

  @override
  State<MoodInsightsPage> createState() => _MoodInsightsPageState();
}

class _MoodInsightsPageState extends State<MoodInsightsPage> {
  _Range _range = _Range.week;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MoodBloc>()..add(const MoodEvent.load()),
      child: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, s) {
          final sum = s.summary;
          return MnPage(
            header: const MnNavHeader(title: 'Insights'),
            maxWidth: 980,
            body: sum == null
                ? const LoadingView()
                : ResponsiveLayout(
                    phone: (_) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _streak(context, sum),
                        const SizedBox(height: 16),
                        _rangeToggle(),
                        const SizedBox(height: 16),
                        _graph(context, sum),
                        const SizedBox(height: 24),
                        _insights(sum),
                        const SizedBox(height: 24),
                        _balance(context, sum),
                      ],
                    ),
                    tablet: (_) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _rangeToggle(),
                              const SizedBox(height: 16),
                              _graph(context, sum),
                              const SizedBox(height: 24),
                              _balance(context, sum),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [_streak(context, sum), const SizedBox(height: 24), _insights(sum)],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _streak(BuildContext context, MoodSummary sum) => FadeUp(
        child: MnCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              StreakRing(streak: sum.streak, best: sum.bestStreak),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${sum.streak} days', style: context.text.title1.copyWith(height: 1)),
                    const SizedBox(height: 4),
                    Text(
                      'Your longest check-in streak yet. Gently does it.',
                      style: context.text.callout.copyWith(color: context.colors.ink2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _rangeToggle() => MnSegmented<_Range>(
        options: _Range.values,
        value: _range,
        labelOf: (r) => r == _Range.week ? 'Week' : 'Month',
        onChanged: (r) => setState(() => _range = r),
      );

  Widget _graph(BuildContext context, MoodSummary sum) {
    final c = context.colors;
    final avg = (_range == _Range.week ? sum.weekAverage : sum.monthAverage).round();
    return MnCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AVERAGE MOOD', style: context.text.cap.copyWith(color: c.ink3)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        MoodFace(level: avg, size: 36),
                        const SizedBox(width: 10),
                        Text(moodLabel(avg), style: context.text.title2),
                      ],
                    ),
                  ],
                ),
              ),
              TrendChip(percent: sum.trendPercent),
            ],
          ),
          const SizedBox(height: 18),
          AnimatedSwitcher(
            duration: MnMotion.base,
            child: _range == _Range.week
                ? MoodWeekBars(key: const ValueKey('w'), levels: sum.week)
                : MnLineChart(
                    key: const ValueKey('m'),
                    values: sum.month.map((e) => e.toDouble()).toList(),
                    height: 130,
                    minValue: 1,
                    maxValue: 5,
                    labels: const ['4w ago', '3w', '2w', '1w', 'Today'],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _insights(MoodSummary sum) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'What we’re noticing'),
          Stagger(spacing: 12, children: [for (final i in sum.insights) InsightCard(insight: i)]),
        ],
      );

  Widget _balance(BuildContext context, MoodSummary sum) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: 'Mood balance · ${sum.month.length} days'),
        MnCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (final e in sum.distribution.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Semantics(
                    label: '${moodLabel(e.key)}: ${e.value} days',
                    excludeSemantics: true,
                    child: Row(
                      children: [
                        MoodFace(level: e.key, size: 30),
                        const SizedBox(width: 12),
                        Expanded(child: MnProgressBar(value: e.value / sum.month.length, height: 10, color: c.mood(e.key))),
                        SizedBox(
                          width: 56,
                          child: Text(
                            '${e.value} days',
                            textAlign: TextAlign.right,
                            style: context.text.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
