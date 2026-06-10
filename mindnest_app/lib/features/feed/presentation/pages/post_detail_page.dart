import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../cubit/post_detail_cubit.dart';
import '../widgets/comment_sheet.dart';
import '../widgets/post_widgets.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    super.key,
    required this.postId,
    this.openComments = false,
  });
  final String postId;
  final bool openComments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostDetailCubit>()..load(postId),
      child: _PostDetailView(postId: postId, openComments: openComments),
    );
  }
}

class _PostDetailView extends StatefulWidget {
  const _PostDetailView({required this.postId, required this.openComments});
  final String postId;
  final bool openComments;
  @override
  State<_PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<_PostDetailView> {
  bool _opened = false;

  void _showComments() => showMnSheet(
    context,
    (_) => CommentSheet(postId: widget.postId),
    maxHeightFactor: 0.78,
  );

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnScaffold(
      child: BlocBuilder<PostDetailCubit, PostDetailState>(
        builder: (context, state) {
          final p = state.post;
          if (p == null) {
            return Column(
              children: [
                SizedBox(height: safeTop(context)),
                NavHeader(transparent: true, onBack: () => context.pop()),
                const Expanded(child: AppLoader()),
              ],
            );
          }
          if (widget.openComments && !_opened) {
            _opened = true;
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _showComments(),
            );
          }
          final cubit = context.read<PostDetailCubit>();
          return Column(
            children: [
              SizedBox(height: safeTop(context)),
              NavHeader(
                transparent: true,
                onBack: () => context.pop(),
                right: const NavBtn(icon: 'share', iconSize: 18, stroke: 1.9),
              ),
              Expanded(
                child: NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
                    children: [
                      PostAuthor(post: p, size: 46),
                      const SizedBox(height: 16),
                      TopicTag(p.topic),
                      const SizedBox(height: 14),
                      Text(
                        p.title,
                        style: MnText.title1.copyWith(
                          color: c.ink,
                          height: 1.18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${p.read} min read',
                        style: MnText.cap.copyWith(color: c.ink3),
                      ),
                      const SizedBox(height: 18),
                      if (p.image) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: PhotoPlaceholder(
                              '${p.topic}${p.id}',
                              label: 'article image',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      Text(
                        p.body,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.7,
                          color: c.ink2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      MnCard(
                        kind: MnCardKind.flat,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Avatar(p.authorName, size: 44, photo: true),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.authorName,
                                    style: MnText.foot.copyWith(
                                      color: c.ink,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    p.authorTitle,
                                    style: MnText.cap.copyWith(color: c.ink3),
                                  ),
                                ],
                              ),
                            ),
                            MnButton(
                              label: 'View',
                              variant: MnVariant.tonal,
                              small: true,
                              expand: false,
                              onPressed: () => context.pushNamed(
                                RouteNames.therapistProfile,
                                pathParameters: {'id': p.authorId},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  22,
                  10,
                  22,
                  safeBottom(context) + 12,
                ),
                decoration: BoxDecoration(
                  color: c.bg.withValues(alpha: 0.95),
                  border: Border(
                    top: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: PostActions(
                  post: p,
                  liked: state.liked,
                  saved: state.saved,
                  onLike: cubit.toggleLike,
                  onSave: cubit.toggleSave,
                  onComment: _showComments,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
