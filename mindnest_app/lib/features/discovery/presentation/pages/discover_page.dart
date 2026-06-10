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

import '../cubit/discover_cubit.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/therapist_card.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DiscoverCubit>()..load(),
      child: const _DiscoverView(),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  const _DiscoverView();
  static const specs = [
    'All',
    'Anxiety',
    'Depression',
    'Sleep',
    'Stress',
    'Relationships',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<DiscoverCubit>();
    return MnScaffold(
      child: Column(
        children: [
          Container(
            color: c.bg,
            padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: NavBtn(icon: 'back', onTap: () => context.pop()),
                    ),
                    Expanded(
                      child: Text(
                        'Find a therapist',
                        style: MnText.title1.copyWith(color: c.ink),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: MnField(
                        icon: 'search',
                        hint: 'Search name or specialty',
                        onChanged: cubit.setQuery,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          showMnSheet(context, (_) => const FilterSheet()),
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: c.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: MnIcon(
                          'filter',
                          size: 22,
                          color: c.onPrimary,
                          stroke: 2.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                BlocBuilder<DiscoverCubit, DiscoverState>(
                  buildWhen: (a, b) => a.spec != b.spec,
                  builder: (context, state) => SizedBox(
                    height: 36,
                    child: NoGlow(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: specs.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (_, i) => Chip2(
                          specs[i],
                          active: state.spec == specs[i],
                          outline: state.spec != specs[i],
                          onTap: () => cubit.setSpec(specs[i]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DiscoverCubit, DiscoverState>(
              builder: (context, state) {
                if (state.status == ViewStatus.loading) {
                  return const AppLoader();
                }
                if (state.status == ViewStatus.error) {
                  return AppErrorView(
                    failure: state.failure!,
                    onRetry: cubit.load,
                  );
                }
                final list = state.filtered;
                if (list.isEmpty) {
                  return EmptyState(
                    icon: 'search',
                    title: 'No therapists found',
                    body:
                        'We couldn’t find a match. Try broadening your filters.',
                    action: 'Clear filters',
                    onAction: cubit.clearFilters,
                  );
                }
                return NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          '${list.length} therapists available',
                          style: MnText.foot.copyWith(color: c.ink3),
                        ),
                      ),
                      for (final t in list) ...[
                        TherapistCard(
                          therapist: t,
                          onTap: () => context.pushNamed(
                            RouteNames.therapistProfile,
                            pathParameters: {'id': t.id},
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
