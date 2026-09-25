import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/therapist_filter.dart';
import '../bloc/discover_bloc.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/therapist_widgets.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DiscoverBloc>()..add(const DiscoverEvent.started()),
      child: const _DiscoverView(),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  const _DiscoverView();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bloc = context.read<DiscoverBloc>();
    return Scaffold(
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, s) {
          final cols = responsive(context, phone: 1, tablet: 2, wide: 3);
          return CustomScrollView(
            physics: Adaptive.scrollPhysics(context),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: c.bg,
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 0,
                expandedHeight: 0,
                collapsedHeight: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(186),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(context.gutter, 0, context.gutter, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            if (context.router.canPop())
                              Transform.translate(
                                offset: const Offset(-8, 0),
                                child: MnIconButton(
                                  icon: MnIcons.back,
                                  tooltip: 'Back',
                                  onPressed: () => context.router.maybePop(),
                                ),
                              ),
                            Expanded(child: Semantics(header: true, child: Text('Find a therapist', style: context.text.title1))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: MnTextField(
                                icon: MnIcons.search,
                                hint: 'Search name or specialty',
                                textInputAction: TextInputAction.search,
                                onChanged: (q) => bloc.add(DiscoverEvent.queryChanged(q)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Badge(
                              isLabelVisible: s.filter.activeCount > 0,
                              label: Text('${s.filter.activeCount}'),
                              backgroundColor: c.clay,
                              child: MnIconButton(
                                icon: MnIcons.filter,
                                tooltip: 'Filters',
                                size: 54,
                                square: true,
                                background: c.primary,
                                color: c.onPrimary,
                                onPressed: () async {
                                  final f = await showFilterSheet(context, s.filter);
                                  if (f != null) bloc.add(DiscoverEvent.filterApplied(f));
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        MnChipRow(
                          padding: EdgeInsets.zero,
                          children: [
                            for (final sp in discoverSpecialties)
                              MnChip(
                                label: sp,
                                outline: true,
                                selected: s.filter.specialty == sp,
                                onTap: () => bloc.add(DiscoverEvent.specialtySelected(sp)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (s.status.isLoading && s.therapists.isEmpty)
                const SliverFillRemaining(hasScrollBody: false, child: LoadingView())
              else if (s.status.isFailure)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorView(message: s.error ?? '', onRetry: () => bloc.add(const DiscoverEvent.started())),
                )
              else if (s.therapists.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    icon: MnIcons.search,
                    title: 'No therapists found',
                    message: 'We couldn’t find a match. Try broadening your filters.',
                    actionLabel: 'Clear filters',
                    onAction: () => bloc.add(const DiscoverEvent.cleared()),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(context.gutter, 8, context.gutter, 12),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      '${s.therapists.length} therapists available',
                      style: context.text.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(context.gutter, 0, context.gutter, 32 + MediaQuery.paddingOf(context).bottom),
                  sliver: SliverToBoxAdapter(
                    child: ResponsiveGrid(
                      columns: cols,
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        for (final (i, t) in s.therapists.indexed)
                          FadeUp(
                            delay: Duration(milliseconds: 40 + 60 * i.clamp(0, 6)),
                            child: TherapistCard(
                              therapist: t,
                              onTap: () => context.router.push(TherapistProfileRoute(therapistId: t.id)),
                              onToggleSaved: () => bloc.add(DiscoverEvent.savedToggled(t.id)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
