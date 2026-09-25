import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../bloc/post_detail_cubit.dart';
import '../widgets/comment_sheet.dart';
import '../widgets/post_widgets.dart';

@RoutePage()
class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, @PathParam('id') required this.postId, this.openComments = false});

  final String postId;
  final bool openComments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostDetailCubit>()..load(postId),
      child: _PostDetailView(openComments: openComments),
    );
  }
}

class _PostDetailView extends StatefulWidget {
  const _PostDetailView({required this.openComments});
  final bool openComments;

  @override
  State<_PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<_PostDetailView> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocConsumer<PostDetailCubit, PostDetailState>(
      listenWhen: (a, b) => a.post == null && b.post != null,
      listener: (context, s) {
        if (widget.openComments && !_opened) {
          _opened = true;
          WidgetsBinding.instance.addPostFrameCallback((_) => showCommentSheet(context));
        }
      },
      builder: (context, s) {
        final p = s.post;
        final cubit = context.read<PostDetailCubit>();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) context.router.pop(p);
          },
          child: Scaffold(
            body: Column(
              children: [
                MnNavHeader(
                  transparent: true,
                  onBack: () => context.router.pop(p),
                  trailing: MnIconButton(
                    icon: MnIcons.share,
                    tooltip: 'Share',
                    iconSize: 18,
                    stroke: 1.9,
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied'))),
                  ),
                ),
                Expanded(
                  child: p == null
                      ? (s.status.isFailure ? ErrorView(message: s.error ?? '') : const LoadingView())
                      : SingleChildScrollView(
                          physics: Adaptive.scrollPhysics(context),
                          padding: const EdgeInsets.fromLTRB(22, 4, 22, 24),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 680),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeUp(child: PostAuthorRow(post: p, size: 46)),
                                  const SizedBox(height: 16),
                                  TopicTag(label: p.topic, color: topicColor(c, p.topic)),
                                  const SizedBox(height: 14),
                                  FadeUp(child: Text(p.title, style: context.text.title1.copyWith(height: 1.18))),
                                  const SizedBox(height: 8),
                                  Text('${p.readMinutes} min read', style: context.text.cap.copyWith(color: c.ink3)),
                                  const SizedBox(height: 18),
                                  if (p.hasImage) ...[
                                    FadeUp(child: MnImagePlaceholder(seed: p.id.hashCode % 5, height: context.isTablet ? 300 : 200, radius: 20)),
                                    const SizedBox(height: 20),
                                  ],
                                  FadeUp(
                                    child: Text(p.body, style: context.text.body.copyWith(fontSize: 17, height: 1.7, color: c.ink2)),
                                  ),
                                  const SizedBox(height: 24),
                                  MnCard(
                                    style: MnCardStyle.flat,
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        MnAvatar(name: p.author.name, size: 44, photo: true),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(p.author.name, style: context.text.foot.copyWith(fontWeight: FontWeight.w700)),
                                              Text(p.author.specialty, style: context.text.cap.copyWith(color: c.ink3)),
                                            ],
                                          ),
                                        ),
                                        MnButton.tonal(
                                          label: 'View',
                                          size: MnButtonSize.small,
                                          expand: false,
                                          onPressed: () => context.router.push(TherapistProfileRoute(therapistId: p.author.id)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                if (p != null)
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(22, 4, 22, MediaQuery.paddingOf(context).bottom + 10),
                        decoration: BoxDecoration(
                          color: c.bg.withValues(alpha: .88),
                          border: Border(top: BorderSide(color: c.hairline, width: .5)),
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 680),
                            child: PostActionsBar(
                              post: p,
                              onLike: cubit.toggleLike,
                              onSave: cubit.toggleSave,
                              onComment: () => showCommentSheet(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
