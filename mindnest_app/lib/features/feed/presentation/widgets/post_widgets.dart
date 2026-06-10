import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../../domain/entities/post.dart';

/// Post author row (uses denormalized author info on the post).
class PostAuthor extends StatelessWidget {
  const PostAuthor({super.key, required this.post, this.size = 42});
  final Post post;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      children: [
        Avatar(post.authorName, size: size, photo: true),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      post.authorName,
                      style: MnText.headline.copyWith(
                        color: c.ink,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Verified(size: 14),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                '${post.authorTitle} · ${post.time}',
                style: MnText.cap.copyWith(color: c.ink3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Like / comment / share / save action row.
class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.post,
    required this.liked,
    required this.saved,
    required this.onLike,
    required this.onSave,
    required this.onComment,
  });
  final Post post;
  final bool liked, saved;
  final VoidCallback onLike, onSave, onComment;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      children: [
        _btn(
          c,
          'heart',
          '${post.likes + (liked ? 1 : 0)}',
          liked,
          c.red,
          fill: true,
          onTap: onLike,
        ),
        const SizedBox(width: 20),
        _btn(
          c,
          'chat2',
          '${post.comments}',
          false,
          c.primary,
          onTap: onComment,
        ),
        const SizedBox(width: 20),
        _btn(c, 'share', null, false, c.primary),
        const Spacer(),
        _btn(c, 'bookmark', null, saved, c.primary, fill: true, onTap: onSave),
      ],
    );
  }

  Widget _btn(
    MnColors c,
    String icon,
    String? count,
    bool active,
    Color color, {
    bool fill = false,
    VoidCallback? onTap,
  }) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MnIcon(
          icon,
          size: 21,
          color: active ? color : c.ink3,
          fill: fill && active ? color : null,
          stroke: active ? 2 : 1.9,
        ),
        if (count != null) ...[
          const SizedBox(width: 6),
          Text(
            count,
            style: MnText.foot.copyWith(
              color: active ? color : c.ink3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    ),
  );
}
