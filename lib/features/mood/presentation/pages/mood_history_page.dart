import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_bloc.dart';
import '../widgets/mood_widgets.dart';

@RoutePage()
class MoodHistoryPage extends StatelessWidget {
  const MoodHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MoodBloc>()..add(const MoodEvent.load()),
      child: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, s) {
          final c = context.colors;
          final sum = s.summary;
          return MnPage(
            header: const MnNavHeader(title: 'Mood history'),
            maxWidth: 720,
            body: sum == null
                ? (s.status.isFailure
                    ? ErrorView(message: s.error ?? '', onRetry: () => context.read<MoodBloc>().add(const MoodEvent.load()))
                    : const LoadingView())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FadeUp(
                        child: MnCard(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('30-DAY AVERAGE', style: context.text.cap.copyWith(color: c.ink3)),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            MoodFace(level: sum.monthAverage.round(), size: 40),
                                            const SizedBox(width: 10),
                                            Flexible(child: Text(moodLabel(sum.monthAverage.round()), style: context.text.title1)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TrendChip(percent: sum.trendPercent),
                                ],
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                height: 80,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    for (var i = 0; i < sum.month.length; i++) ...[
                                      if (i > 0) const SizedBox(width: 3),
                                      Expanded(
                                        child: FractionallySizedBox(
                                          heightFactor: sum.month[i] * .18,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: c.mood(sum.month[i]).withValues(alpha: .9),
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('4 weeks ago', style: context.text.cap.copyWith(color: c.ink3)),
                                  Text('Today', style: context.text.cap.copyWith(color: c.ink3)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      const SectionHeader(title: 'Recent entries'),
                      Stagger(
                        spacing: 12,
                        children: [for (final e in sum.recent) MoodEntryCard(entry: e)],
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class MoodEntryCard extends StatelessWidget {
  const MoodEntryCard({super.key, required this.entry});
  final MoodEntry entry;

  String _day(DateTime d) {
    final now = DateTime.now();
    final diff = DateTime(now.year, now.month, now.day).difference(DateTime(d.year, d.month, d.day)).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat.E().format(d);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      style: MnCardStyle.flat,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoodFace(level: entry.level, size: 48),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(_day(entry.createdAt), style: context.text.headline),
                    const SizedBox(width: 8),
                    Text(DateFormat.jm().format(entry.createdAt), style: context.text.foot.copyWith(color: c.ink3)),
                  ],
                ),
                if (entry.note.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(entry.note, style: context.text.callout.copyWith(color: c.ink2)),
                ],
                if (entry.factors.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final f in entry.factors)
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: c.hairline2, width: 1.5),
                          ),
                          child: Text(f, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.ink2)),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
