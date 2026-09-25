import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/post.dart';

class PostAuthorRow extends StatelessWidget {
  const PostAuthorRow({super.key, required this.post, this.size = 42});
  final Post post;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        MnAvatar(name: post.author.name, size: size, photo: true),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(post.author.name, style: context.text.headline.copyWith(fontSize: 15), overflow: TextOverflow.ellipsis),
                  ),
                  if (post.author.verified) ...[const SizedBox(width: 5), const VerifiedBadge(size: 14)],
                ],
              ),
              const SizedBox(height: 1),
              Text('${post.author.title} · ${timeAgo(post.publishedAt)}', style: context.text.cap.copyWith(color: c.ink3)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Like · comment · share · save (`PostActions`).
class PostActionsBar extends StatelessWidget {
  const PostActionsBar({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onSave,
    this.onShare,
  });

  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onSave;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget btn(MnIconData icon, {int? count, bool active = false, Color? color, required VoidCallback onTap, required String label}) =>
        Semantics(
          button: true,
          toggled: active,
          label: label,
          excludeSemantics: true,
          child: Pressable(
            onTap: onTap,
            scale: .9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: active ? 1.1 : 1,
                    duration: MnMotion.base,
                    curve: MnMotion.easeSpring,
                    child: MnIcon(icon, size: 21, color: active ? color : c.ink3, filled: active && color != null, stroke: active ? 2 : 1.9),
                  ),
                  if (count != null) ...[
                    const SizedBox(width: 6),
                    Text('$count', style: context.text.foot.copyWith(fontWeight: FontWeight.w600, color: active ? color : c.ink3)),
                  ],
                ],
              ),
            ),
          ),
        );
    return Row(
      children: [
        btn(MnIcons.heart, count: post.likes, active: post.liked, color: c.red, onTap: onLike, label: post.liked ? 'Unlike' : 'Like'),
        const SizedBox(width: 20),
        btn(MnIcons.chat2, count: post.comments, onTap: onComment, label: 'Comments'),
        const SizedBox(width: 20),
        btn(MnIcons.share, onTap: onShare ?? () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied'))), label: 'Share'),
        const Spacer(),
        btn(MnIcons.bookmark, active: post.saved, color: c.primary, onTap: onSave, label: post.saved ? 'Remove from saved' : 'Save'),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLike,
    required this.onComment,
    required this.onSave,
    this.seed = 0,
  });

  final Post post;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onSave;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      semanticLabel: post.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: PostAuthorRow(post: post)),
              const SizedBox(width: 8),
              TopicTag(label: post.topic, color: topicColor(c, post.topic), small: true),
            ],
          ),
          const SizedBox(height: 13),
          if (post.hasImage) ...[MnImagePlaceholder(seed: seed, height: 150), const SizedBox(height: 13)],
          Text(post.title, style: context.text.title3),
          const SizedBox(height: 6),
          Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.callout.copyWith(color: c.ink2, height: 1.5)),
          const SizedBox(height: 6),
          Text('${post.readMinutes} min read', style: context.text.cap.copyWith(color: c.ink3)),
          const SizedBox(height: 12),
          const Hairline(),
          PostActionsBar(post: post, onLike: onLike, onComment: onComment, onSave: onSave),
        ],
      ),
    );
  }
}

/// Tablet grid card.
class PostGridCard extends StatelessWidget {
  const PostGridCard({super.key, required this.post, required this.onTap, required this.onLike, required this.onSave, this.seed = 0});
  final Post post;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      style: MnCardStyle.flat,
      radius: 20,
      onTap: onTap,
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (post.hasImage) MnImagePlaceholder(seed: seed, height: 150, radius: 0),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.topic.toUpperCase(), style: context.text.cap.copyWith(color: topicColor(c, post.topic), fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(post.title, style: context.text.title3),
                const SizedBox(height: 6),
                Text(post.excerpt, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.sub.copyWith(color: c.ink2, height: 1.5)),
                const SizedBox(height: 8),
                PostActionsBar(post: post, onLike: onLike, onComment: onTap, onSave: onSave),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Tablet hero post.
class FeaturedPostCard extends StatelessWidget {
  const FeaturedPostCard({super.key, required this.post, required this.onTap});
  final Post post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      clip: true,
      radius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MnImagePlaceholder(seed: 0, height: 220, radius: 0),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${post.topic.toUpperCase()} · FEATURED',
                    style: context.text.cap.copyWith(color: topicColor(c, post.topic), fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(post.title, style: context.text.title2),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(post.excerpt, style: context.text.body.copyWith(color: c.ink2)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    MnAvatar(name: post.author.name, size: 34, photo: true),
                    const SizedBox(width: 10),
                    Text(post.author.name, style: context.text.sub.copyWith(fontWeight: FontWeight.w600)),
                    Text('  · ${post.readMinutes} min read', style: context.text.cap.copyWith(color: c.ink3)),
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

/// Compact row for "Recommended reading".
class PostMiniRow extends StatelessWidget {
  const PostMiniRow({super.key, required this.post, required this.onTap, this.seed = 1});
  final Post post;
  final VoidCallback onTap;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .98,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(width: 72, child: MnImagePlaceholder(seed: seed, height: 56, radius: 12)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.topic.toUpperCase(), style: context.text.cap.copyWith(color: topicColor(c, post.topic), fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(post.title, style: context.text.sub.copyWith(fontWeight: FontWeight.w600, height: 1.3)),
                  const SizedBox(height: 2),
                  Text('${post.readMinutes} min read', style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
