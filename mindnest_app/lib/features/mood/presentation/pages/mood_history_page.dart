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
import '../cubit/mood_history_cubit.dart';

class MoodHistoryPage extends StatelessWidget {
  const MoodHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocProvider(
      create: (_) => getIt<MoodHistoryCubit>()..load(),
      child: MnScaffold(
        child: Column(
          children: [
            SizedBox(height: safeTop(context)),
            NavHeader(title: 'Mood history', onBack: () => context.pop()),
            Expanded(
              child: BlocBuilder<MoodHistoryCubit, MoodHistoryState>(
                builder: (context, state) {
                  if (state.status == ViewStatus.error) {
                    return AppErrorView(
                      failure: state.failure!,
                      onRetry: context.read<MoodHistoryCubit>().load,
                    );
                  }
                  final h = state.history;
                  if (h == null) return const AppLoader();
                  return NoGlow(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                      children: [
                        MnCard(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '30-DAY AVERAGE',
                                          style: MnText.cap.copyWith(
                                            color: c.ink3,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            MoodFace(
                                              level: h.average,
                                              size: 40,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              moodLabels[h.average - 1],
                                              style: MnText.title1.copyWith(
                                                color: c.ink,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Chip2(
                                    h.trendLabel,
                                    outline: true,
                                    leading: MnIcon(
                                      'trend',
                                      size: 15,
                                      color: c.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                height: 80,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    for (
                                      var i = 0;
                                      i < h.monthLevels.length;
                                      i++
                                    )
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: i == 0 ? 0 : 3,
                                          ),
                                          child: FractionallySizedBox(
                                            heightFactor: h.monthLevels[i] / 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: c
                                                    .moodColor(h.monthLevels[i])
                                                    .withValues(alpha: 0.9),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '4 weeks ago',
                                    style: MnText.cap.copyWith(color: c.ink3),
                                  ),
                                  Text(
                                    'Today',
                                    style: MnText.cap.copyWith(color: c.ink3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        const SectionHead('Recent entries'),
                        for (final e in h.recent) ...[
                          _entryCard(c, e),
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryCard(MnColors c, MoodEntry e) => MnCard(
    kind: MnCardKind.flat,
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoodFace(level: e.level, size: 48),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(e.day, style: MnText.headline.copyWith(color: c.ink)),
                  const SizedBox(width: 8),
                  Text(e.time, style: MnText.foot.copyWith(color: c.ink3)),
                ],
              ),
              const SizedBox(height: 4),
              Text(e.note, style: MnText.callout.copyWith(color: c.ink2)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final f in e.factors)
                    Chip2(f, outline: true, height: 26),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
