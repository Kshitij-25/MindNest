import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/post.dart';
import '../bloc/feed_bloc.dart';
import '../widgets/post_widgets.dart';

@RoutePage()
class FeedPage extends StatelessWidget {
  const FeedPage({super.key, this.savedOnly = false});

  final bool savedOnly;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedBloc>()..add(FeedEvent.load(savedOnly: savedOnly)),
      child: _FeedView(savedOnly: savedOnly),
    );
  }
}

class _FeedView extends StatelessWidget {
  const _FeedView({required this.savedOnly});
  final bool savedOnly;

  Future<void> _open(BuildContext context, Post p, {bool comments = false}) async {
    final bloc = context.read<FeedBloc>();
    final updated = await context.router.push<Post>(PostDetailRoute(postId: p.id, openComments: comments));
    if (updated != null) bloc.add(FeedEvent.postUpdated(updated));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, s) {
        final bloc = context.read<FeedBloc>();
        final tablet = context.isTablet;
        Widget content;
        if (s.status.isLoading && s.posts.isEmpty) {
          content = const LoadingView();
        } else if (s.posts.isEmpty) {
          content = EmptyState(
            icon: savedOnly ? MnIcons.bookmark : MnIcons.layers,
            title: savedOnly ? 'Nothing saved yet' : 'No posts in this space',
            message: savedOnly
                ? 'Tap the bookmark on any post to keep it here for later.'
                : 'Try another space to explore more reflections.',
            actionLabel: savedOnly ? null : 'Back to For you',
            onAction: () => bloc.add(const FeedEvent.topicChanged('For you')),
          );
        } else if (tablet && !savedOnly) {
          final featured = s.posts.first;
          final rest = s.posts.skip(1).toList();
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeUp(child: FeaturedPostCard(post: featured, onTap: () => _open(context, featured))),
              const SizedBox(height: 20),
              ResponsiveGrid(
                columns: context.isWide ? 3 : 2,
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (final (i, p) in rest.indexed)
                    FadeUp(
                      delay: Duration(milliseconds: 60 * (i + 1)),
                      child: PostGridCard(
                        post: p,
                        seed: i + 2,
                        onTap: () => _open(context, p),
                        onLike: () => bloc.add(FeedEvent.likeToggled(p)),
                        onSave: () => bloc.add(FeedEvent.saveToggled(p)),
                      ),
                    ),
                ],
              ),
            ],
          );
        } else {
          content = Stagger(
            spacing: 14,
            children: [
              for (final (i, p) in s.posts.indexed)
                PostCard(
                  post: p,
                  seed: i,
                  onTap: () => _open(context, p),
                  onLike: () => bloc.add(FeedEvent.likeToggled(p)),
                  onComment: () => _open(context, p, comments: true),
                  onSave: () => bloc.add(FeedEvent.saveToggled(p)),
                ),
            ],
          );
        }

        return MnPage(
          header: savedOnly ? const MnNavHeader(title: 'Saved posts') : null,
          maxWidth: 1100,
          padding: EdgeInsets.fromLTRB(context.gutter, savedOnly ? 8 : 16, context.gutter, 32),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!savedOnly) ...[
                LargeTitle(
                  title: 'Spaces',
                  trailing: tablet
                      ? null
                      : MnIconButton(
                          icon: MnIcons.bell,
                          tooltip: 'Notifications',
                          iconSize: 20,
                          stroke: 1.9,
                          badge: true,
                          onPressed: () => context.router.push(const NotificationsRoute()),
                        ),
                ),
                const SizedBox(height: 12),
                MnChipRow(
                  padding: EdgeInsets.zero,
                  children: [
                    for (final t in feedTopics)
                      MnChip(
                        label: t,
                        outline: true,
                        selected: s.topic == t,
                        onTap: () => bloc.add(FeedEvent.topicChanged(t)),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              AnimatedSwitcher(duration: MnMotion.base, child: KeyedSubtree(key: ValueKey(s.topic), child: content)),
              if (s.posts.isNotEmpty) ...[
                const SizedBox(height: 20),
                Center(child: Text('You’re all caught up', style: context.text.foot.copyWith(color: c.ink3))),
              ],
            ],
          ),
        );
      },
    );
  }
}
