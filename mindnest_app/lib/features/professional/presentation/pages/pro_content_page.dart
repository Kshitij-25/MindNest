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

import '../../domain/entities/professional.dart';
import '../cubit/pro_content_cubit.dart';

String _compact(int n) =>
    n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';

/// Content tab. Hosted inside the pro shell.
class ProContentPage extends StatelessWidget {
  const ProContentPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProContentCubit>()..load(),
    child: const _ContentView(),
  );
}

class _ContentView extends StatelessWidget {
  const _ContentView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<ProContentCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Content',
                  style: MnText.title1.copyWith(color: c.ink),
                ),
              ),
              NavBtn(
                icon: 'plus',
                iconSize: 22,
                stroke: 2.2,
                background: c.primary,
                color: c.onPrimary,
                onTap: () => context.pushNamed(RouteNames.createPost),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ProContentCubit, ProContentState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading ||
                  state.status == ViewStatus.initial) {
                return const AppLoader();
              }
              if (state.status == ViewStatus.error) {
                return AppErrorView(
                  failure: state.failure!,
                  onRetry: cubit.load,
                );
              }
              final list = state.filtered;
              return NoGlow(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
                  children: [
                    Segmented(
                      options: const ['Published', 'Drafts'],
                      value: state.tab,
                      onChanged: cubit.setTab,
                    ),
                    const SizedBox(height: 16),
                    MnCard(
                      kind: MnCardKind.flat,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          _StatCell(
                            value: '${state.totalPosts}',
                            label: 'Posts',
                          ),
                          Container(width: 0.5, height: 32, color: c.hairline),
                          _StatCell(
                            value: _compact(state.totalViews),
                            label: 'Views',
                          ),
                          Container(width: 0.5, height: 32, color: c.hairline),
                          _StatCell(
                            value: _compact(state.totalLikes),
                            label: 'Likes',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (list.isEmpty)
                      const EmptyState(
                        icon: 'feather',
                        title: 'No drafts',
                        body:
                            'Start writing — your unpublished posts will be saved here.',
                      )
                    else
                      for (final p in list) ...[
                        _PostCard(post: p),
                        const SizedBox(height: 12),
                      ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});
  final String value, label;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Expanded(
      child: Column(
        children: [
          Text(value, style: MnText.title3.copyWith(color: c.ink)),
          const SizedBox(height: 2),
          Text(label, style: MnText.cap.copyWith(color: c.ink3)),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});
  final ProPost post;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final p = post;
    final isDraft = p.status == 'Draft';
    return MnCard(
      onTap: () => context.pushNamed(
        RouteNames.createPost,
        queryParameters: {'id': p.id},
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 64,
              height: 64,
              child: p.image
                  ? PhotoPlaceholder('${p.topic}${p.id}')
                  : Container(
                      color: c.fill,
                      alignment: Alignment.center,
                      child: MnIcon(
                        'feather',
                        size: 24,
                        color: c.ink4,
                        stroke: 1.7,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TopicTag(p.topic, sm: true),
                    if (isDraft) ...[
                      const SizedBox(width: 6),
                      const Badge2(
                        'Draft',
                        kind: BadgeKind.pending,
                        height: 22,
                        fontSize: 11,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MnText.headline.copyWith(color: c.ink, fontSize: 15),
                ),
                const SizedBox(height: 8),
                if (isDraft)
                  Text(
                    'Last edited 2 days ago',
                    style: MnText.cap.copyWith(color: c.ink3, letterSpacing: 0),
                  )
                else
                  Row(
                    children: [
                      _Metric(icon: 'eye', value: _compact(p.views)),
                      const SizedBox(width: 14),
                      _Metric(icon: 'heart', value: '${p.likes}'),
                      const SizedBox(width: 14),
                      _Metric(icon: 'chat2', value: '${p.comments}'),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.value});
  final String icon, value;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MnIcon(icon, size: 14, color: c.ink3, stroke: 1.9),
        const SizedBox(width: 5),
        Text(
          value,
          style: MnText.cap.copyWith(color: c.ink3, letterSpacing: 0),
        ),
      ],
    );
  }
}
