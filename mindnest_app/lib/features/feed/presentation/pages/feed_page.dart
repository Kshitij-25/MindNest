import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/post.dart';
import '../cubit/feed_cubit.dart';
import '../widgets/post_widgets.dart';

/// Spaces (content feed) tab.
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<FeedCubit>()..load(),
    child: const _FeedView(),
  );
}

class _FeedView extends StatelessWidget {
  const _FeedView();
  static const topics = [
    'For you',
    'Anxiety',
    'Sleep',
    'Mindfulness',
    'Relationships',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<FeedCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppPhase.mvp1 ? 'Discover & Learn' : 'Spaces',
                      style: MnText.title1.copyWith(color: c.ink),
                    ),
                  ),
                  NavBtn(
                    icon: 'bell',
                    iconSize: 20,
                    stroke: 1.9,
                    badge: true,
                    onTap: () => context.pushNamed(RouteNames.notifications),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              BlocBuilder<FeedCubit, FeedState>(
                buildWhen: (a, b) => a.topic != b.topic,
                builder: (context, state) => SizedBox(
                  height: 36,
                  child: NoGlow(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: topics.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, i) => Chip2(
                        topics[i],
                        active: state.topic == topics[i],
                        outline: state.topic != topics[i],
                        onTap: () => cubit.setTopic(topics[i]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<FeedCubit, FeedState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading) return const AppLoader();
              if (state.status == ViewStatus.error) {
                return AppErrorView(failure: state.failure!, onRetry: cubit.load);
              }
              final list = state.filtered;
              if (list.isEmpty) {
                return EmptyState(
                  icon: 'layers',
                  title: 'No posts in this space',
                  body: 'Try another space to explore more reflections.',
                  action: 'Back to For you',
                  onAction: () => cubit.setTopic('For you'),
                );
              }
              return NoGlow(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (_, i) =>
                      _postCard(context, c, cubit, state, list[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _postCard(
    BuildContext context,
    MnColors c,
    FeedCubit cubit,
    FeedState state,
    Post p,
  ) {
    return MnCard(
      onTap: () => context.pushNamed(
        RouteNames.postDetail,
        pathParameters: {'id': p.id},
      ),
      pressable: false,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: PostAuthor(post: p)),
              const SizedBox(width: 8),
              TopicTag(p.topic, sm: true),
            ],
          ),
          const SizedBox(height: 13),
          if (p.image) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: PhotoPlaceholder(
                  '${p.topic}${p.id}',
                  label: 'article image',
                ),
              ),
            ),
            const SizedBox(height: 13),
          ],
          Text(p.title, style: MnText.title3.copyWith(color: c.ink)),
          const SizedBox(height: 6),
          Text(
            p.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
          ),
          const SizedBox(height: 6),
          Text('${p.read} min read', style: MnText.cap.copyWith(color: c.ink3)),
          // Social actions (like / save / comment) are community features —
          // hidden in MVP 1, where the feed is a read-only wellness library.
          if (!AppPhase.mvp1) ...[
            const SizedBox(height: 12),
            const Hairline(margin: EdgeInsets.only(bottom: 8)),
            PostActions(
              post: p,
              liked: state.liked(p),
              saved: state.saved(p),
              onLike: () => cubit.toggleLike(p),
              onSave: () => cubit.toggleSave(p),
              onComment: () => context.pushNamed(
                RouteNames.postDetail,
                pathParameters: {'id': p.id},
                queryParameters: {'comments': '1'},
              ),
            ),
          ],
        ],
      ),
    );
  }
}
