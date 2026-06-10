import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/mood.dart';
import '../cubit/mood_insights_cubit.dart';
import '../widgets/mood_charts.dart';

class MoodInsightsPage extends StatelessWidget {
  const MoodInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoodInsightsCubit>()..load(),
      child: MnScaffold(
        child: Column(
          children: [
            SizedBox(height: safeTop(context)),
            NavHeader(title: 'Insights', onBack: () => context.pop()),
            Expanded(
              child: BlocBuilder<MoodInsightsCubit, MoodInsightsState>(
                builder: (context, state) {
                  if (state.status == ViewStatus.error) {
                    return AppErrorView(
                      failure: state.failure!,
                      onRetry: context.read<MoodInsightsCubit>().load,
                    );
                  }
                  final ins = state.insights;
                  if (ins == null) return const AppLoader();
                  return _InsightsView(
                    insights: ins,
                    range: state.range,
                    onRange: context.read<MoodInsightsCubit>().setRange,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightsView extends StatelessWidget {
  const _InsightsView({
    required this.insights,
    required this.range,
    required this.onRange,
  });
  final MoodInsights insights;
  final String range;
  final ValueChanged<String> onRange;
  static const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ins = insights;
    return NoGlow(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 30),
        children: [
          MnCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                StreakRing(
                  value: ins.streakDays / ins.streakGoal,
                  track: c.fill2,
                  color: c.streak,
                  child: MnIcon(
                    'flame',
                    size: 30,
                    color: c.streak,
                    stroke: 1.7,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ins.streakDays} days',
                        style: MnText.title1.copyWith(color: c.ink, height: 1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your longest check-in streak yet. Gently does it.',
                        style: MnText.callout.copyWith(color: c.ink2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Segmented(
            options: const ['Week', 'Month'],
            value: range,
            onChanged: onRange,
          ),
          const SizedBox(height: 16),
          MnCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AVERAGE MOOD',
                            style: MnText.cap.copyWith(color: c.ink3),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              MoodFace(level: ins.average, size: 36),
                              const SizedBox(width: 10),
                              Text(
                                moodLabels[ins.average - 1],
                                style: MnText.title2.copyWith(color: c.ink),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Chip2(
                      ins.trendLabel,
                      outline: true,
                      leading: MnIcon('trend', size: 15, color: c.green),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 130,
                  child: range == 'Week'
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (var i = 0; i < ins.week.length; i++)
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: i == 0 ? 0 : 4,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: FractionallySizedBox(
                                            heightFactor: ins.week[i] / 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: c.moodColor(ins.week[i]),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        days[i][0],
                                        style: MnText.cap.copyWith(
                                          color: c.ink3,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                      : MoodLineChart(
                          data: ins.month,
                          color: c.primary,
                          surface: c.surface,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHead('What we’re noticing'),
          for (final card in ins.cards) ...[
            MnCard(
              kind: MnCardKind.flat,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tint(c.topic[card.topicIndex], 0.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: MnIcon(
                      card.icon,
                      size: 20,
                      color: c.topic[card.topicIndex],
                      stroke: 1.9,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.title,
                          style: MnText.headline.copyWith(
                            color: c.ink,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          card.body,
                          style: MnText.callout.copyWith(
                            color: c.ink2,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          const SectionHead('Mood balance · 28 days'),
          MnCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                for (final d in ins.distribution)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        MoodFace(level: d.level, size: 30),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              height: 10,
                              color: c.fill2,
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: d.count / 28,
                                child: Container(color: c.moodColor(d.level)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 44,
                          child: Text(
                            '${d.count} days',
                            textAlign: TextAlign.right,
                            style: MnText.foot.copyWith(
                              color: c.ink3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
