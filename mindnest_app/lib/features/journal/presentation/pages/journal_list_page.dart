import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../cubit/journal_list_cubit.dart';
import '../widgets/journal_calendar.dart';
import '../widgets/journal_row.dart';

/// Journal tab — hosted inside the user shell, so it returns content (no Scaffold).
class JournalListPage extends StatelessWidget {
  const JournalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<JournalListCubit>()..load(),
      child: const _JournalListView(),
    );
  }
}

class _JournalListView extends StatelessWidget {
  const _JournalListView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<JournalListCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Journal',
                      style: MnText.title1.copyWith(color: c.ink),
                    ),
                  ),
                  NavBtn(
                    icon: 'pen',
                    iconSize: 19,
                    stroke: 2,
                    background: c.primary,
                    color: c.onPrimary,
                    onTap: () => context.pushNamed(RouteNames.journalWrite),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              BlocBuilder<JournalListCubit, JournalListState>(
                buildWhen: (a, b) => a.view != b.view,
                builder: (context, state) => Segmented(
                  options: const ['List', 'Calendar'],
                  value: state.view,
                  onChanged: cubit.setView,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<JournalListCubit, JournalListState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading) return const AppLoader();
              if (state.status == ViewStatus.error) {
                return AppErrorView(
                  failure: state.failure!,
                  onRetry: cubit.load,
                );
              }
              if (state.view == 'Calendar') {
                return NoGlow(
                  child: JournalCalendar(
                    onPick: () => context.pushNamed(
                      RouteNames.journalEntry,
                      pathParameters: {'id': 'j1'},
                    ),
                  ),
                );
              }
              return NoGlow(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  itemCount: state.entries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final j = state.entries[i];
                    return JournalRow(
                      entry: j,
                      onTap: () => j.draft
                          ? context.pushNamed(RouteNames.journalWrite, extra: j)
                          : context.pushNamed(
                              RouteNames.journalEntry,
                              pathParameters: {'id': j.id},
                            ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
