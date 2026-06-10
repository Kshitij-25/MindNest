import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../cubit/journal_entry_cubit.dart';

class JournalEntryPage extends StatelessWidget {
  const JournalEntryPage({super.key, required this.entryId});
  final String entryId;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocProvider(
      create: (_) => getIt<JournalEntryCubit>()..load(entryId),
      child: MnScaffold(
        background: c.paper,
        child: BlocBuilder<JournalEntryCubit, JournalEntryState>(
          builder: (context, state) {
            final j = state.entry;
            if (j == null || state.status == ViewStatus.loading) {
              return Column(
                children: [
                  SizedBox(height: safeTop(context)),
                  NavHeader(transparent: true, onBack: () => context.pop()),
                  const Expanded(child: AppLoader()),
                ],
              );
            }
            return Column(
              children: [
                SizedBox(height: safeTop(context)),
                NavHeader(
                  transparent: true,
                  onBack: () => context.pop(),
                  right: NavBtn(
                    icon: 'pen',
                    iconSize: 18,
                    stroke: 1.9,
                    onTap: () =>
                        context.pushNamed(RouteNames.journalWrite, extra: j),
                  ),
                ),
                Expanded(
                  child: NoGlow(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(26, 8, 26, 40),
                      children: [
                        Row(
                          children: [
                            MoodFace(level: j.mood, size: 52),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  moodLabels[j.mood - 1],
                                  style: MnText.headline.copyWith(color: c.ink),
                                ),
                                Text(
                                  '${j.day} · ${j.date} · ${j.time}',
                                  style: MnText.foot.copyWith(color: c.ink3),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          j.displayTitle,
                          style: MnText.serif(
                            size: 30,
                            color: c.ink,
                          ).copyWith(height: 1.15),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          j.body,
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.7,
                            color: c.ink2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [for (final t in j.tags) TopicTag(t)],
                        ),
                        const Hairline(
                          margin: EdgeInsets.fromLTRB(0, 28, 0, 16),
                        ),
                        Row(
                          children: [
                            MnIcon('lock', size: 15, color: c.ink3),
                            const SizedBox(width: 8),
                            Text(
                              'Private · only visible to you',
                              style: MnText.foot.copyWith(color: c.ink3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
