import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../feed/domain/entities/post.dart';
import '../bloc/content_cubit.dart';

String _compact(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}k' : '$v';

@RoutePage()
class ProContentPage extends StatelessWidget {
  const ProContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ContentCubit>()..load(),
      child: BlocBuilder<ContentCubit, ContentState>(
        builder: (context, s) {
          final c = context.colors;
          final cubit = context.read<ContentCubit>();
          final tablet = context.isTablet;
          final published = s.posts.where((p) => p.status == PostStatus.published).length;
          void write([Post? p]) => context.router.push(CreatePostRoute(postId: p?.id));

          return MnPage(
            maxWidth: 1100,
            padding: EdgeInsets.fromLTRB(context.gutter, 16, context.gutter, 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LargeTitle(
                  title: tablet ? 'Content studio' : 'Content',
                  trailing: tablet
                      ? MnButton(label: 'Write a post', icon: MnIcons.feather, size: MnButtonSize.small, expand: false, onPressed: write)
                      : MnIconButton(
                          icon: MnIcons.plus,
                          tooltip: 'Write a post',
                          background: c.primary,
                          color: c.onPrimary,
                          onPressed: write,
                        ),
                ),
                const SizedBox(height: 16),
                if (tablet)
                  ResponsiveGrid(
                    columns: 3,
                    spacing: 16,
                    children: [
                      StatTile(icon: MnIcons.eye, value: _compact(s.totalViews), label: 'Total views', delta: '+12%'),
                      StatTile(icon: MnIcons.heart, color: c.clay, value: '${s.totalLikes}', label: 'Reactions', delta: '+9%'),
                      StatTile(icon: MnIcons.chat2, color: c.topics[0], value: '${s.totalComments}', label: 'Comments', delta: '+6%'),
                    ],
                  )
                else
                  MnCard(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          for (final (i, (v, k)) in [('$published', 'Posts'), (_compact(s.totalViews), 'Views'), ('${s.totalLikes}', 'Likes')].indexed) ...[
                            if (i > 0) Container(width: 1, color: c.hairline),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(v, style: context.text.title2.copyWith(color: c.primary)),
                                  const SizedBox(height: 2),
                                  Text(k, style: context.text.cap.copyWith(color: c.ink3)),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 18),
                if (tablet)
                  Row(
                    children: [
                      for (final f in ContentFilter.values) ...[
                        MnChip(label: _label(f), selected: s.filter == f, onTap: () => cubit.setFilter(f)),
                        const SizedBox(width: 8),
                      ],
                    ],
                  )
                else
                  MnSegmented<ContentFilter>(
                    options: const [ContentFilter.published, ContentFilter.drafts],
                    value: s.filter == ContentFilter.all ? ContentFilter.published : s.filter,
                    labelOf: _label,
                    onChanged: cubit.setFilter,
                  ),
                const SizedBox(height: 16),
                if (s.status.isLoading && s.posts.isEmpty)
                  const LoadingView()
                else if (s.visible.isEmpty)
                  EmptyState(
                    icon: MnIcons.feather,
                    title: 'No drafts',
                    message: 'Start writing a reflection — save it as a draft and publish when it feels ready.',
                    actionLabel: 'Write a post',
                    onAction: write,
                  )
                else
                  ResponsiveGrid(
                    columns: tablet ? 2 : 1,
                    spacing: 16,
                    runSpacing: 14,
                    children: [
                      for (final (i, p) in s.visible.indexed)
                        FadeUp(
                          delay: Duration(milliseconds: 50 * i),
                          child: tablet ? _GridPost(post: p, seed: i, onTap: () => write(p)) : _RowPost(post: p, onTap: () => write(p)),
                        ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  static String _label(ContentFilter f) => switch (f) {
        ContentFilter.all => 'All',
        ContentFilter.published => 'Published',
        ContentFilter.drafts => 'Drafts',
      };
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget m(MnIconData i, int v) => Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MnIcon(i, size: 14, color: c.ink3, stroke: 1.9),
              const SizedBox(width: 5),
              Text(_compact(v), style: context.text.cap.copyWith(color: c.ink3)),
            ],
          ),
        );
    return Row(children: [m(MnIcons.eye, post.views), m(MnIcons.heart, post.likes), m(MnIcons.chat2, post.comments)]);
  }
}

class _RowPost extends StatelessWidget {
  const _RowPost({required this.post, required this.onTap});
  final Post post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final draft = post.status == PostStatus.draft;
    return MnCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: post.hasImage
                ? MnImagePlaceholder(seed: post.id.hashCode % 5, height: 64, radius: 14)
                : Container(
                    decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(14)),
                    alignment: Alignment.center,
                    child: MnIcon(MnIcons.feather, size: 24, color: c.ink4, stroke: 1.7),
                  ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TopicTag(label: post.topic, color: topicColor(c, post.topic), small: true),
                    if (draft) ...[const SizedBox(width: 8), const MnBadge(label: 'Draft', tone: MnBadgeTone.pending)],
                  ],
                ),
                const SizedBox(height: 4),
                Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.headline.copyWith(fontSize: 15, height: 1.3)),
                const SizedBox(height: 8),
                if (draft)
                  Text('Last edited ${timeAgo(post.publishedAt)} ago', style: context.text.cap.copyWith(color: c.ink3))
                else
                  _Metrics(post: post),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPost extends StatelessWidget {
  const _GridPost({required this.post, required this.seed, required this.onTap});
  final Post post;
  final int seed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final draft = post.status == PostStatus.draft;
    return MnCard(
      style: MnCardStyle.flat,
      radius: 20,
      onTap: onTap,
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          post.hasImage
              ? MnImagePlaceholder(seed: seed, height: 130, radius: 0)
              : Container(height: 130, color: c.surface3, alignment: Alignment.center, child: MnIcon(MnIcons.feather, size: 30, color: c.ink4, stroke: 1.6)),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MnBadge.status(draft ? 'Draft' : 'Published'),
                    const SizedBox(width: 8),
                    Text('${post.topic} · ${timeAgo(post.publishedAt)}', style: context.text.cap.copyWith(color: c.ink3)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(post.title, style: context.text.title3),
                const SizedBox(height: 12),
                _Metrics(post: post),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
