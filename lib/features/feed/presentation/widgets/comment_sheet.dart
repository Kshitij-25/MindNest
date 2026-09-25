import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/post_detail_cubit.dart';

Future<void> showCommentSheet(BuildContext context) {
  final cubit = context.read<PostDetailCubit>()..loadComments();
  return showMnSheet<void>(
    context,
    expand: true,
    builder: (_) => BlocProvider.value(value: cubit, child: const _CommentSheet()),
  );
}

class _CommentSheet extends StatefulWidget {
  const _CommentSheet();

  @override
  State<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<_CommentSheet> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final ok = await context.read<PostDetailCubit>().addComment(_ctrl.text);
    if (ok) _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<PostDetailCubit, PostDetailState>(
      builder: (context, s) {
        final canSend = _ctrl.text.trim().isNotEmpty && !s.sending;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 12, 10),
              child: Row(
                children: [
                  Expanded(child: Text('Comments · ${s.comments.length}', style: context.text.title3)),
                  MnIconButton(
                    icon: MnIcons.x,
                    tooltip: 'Close',
                    background: Colors.transparent,
                    color: c.ink3,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Hairline(),
            Flexible(
              child: s.commentsLoading
                  ? const LoadingView()
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                      itemCount: s.comments.length,
                      itemBuilder: (context, i) {
                        final cm = s.comments[i];
                        return FadeUp(
                          offset: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MnAvatar(name: cm.author, size: 36),
                                const SizedBox(width: 11),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MnCard(
                                        style: MnCardStyle.inset,
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(cm.author, style: context.text.foot.copyWith(fontWeight: FontWeight.w700)),
                                                const SizedBox(width: 8),
                                                Text(timeAgo(cm.createdAt), style: context.text.cap.copyWith(color: c.ink3)),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Text(cm.text, style: context.text.callout.copyWith(color: c.ink2, height: 1.45)),
                                          ],
                                        ),
                                      ),
                                      Pressable(
                                        onTap: () => context.read<PostDetailCubit>().toggleCommentLike(cm),
                                        semanticLabel: cm.liked ? 'Unlike comment' : 'Like comment',
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              MnIcon(MnIcons.heart, size: 14, color: cm.liked ? c.red : c.ink3, filled: cm.liked),
                                              const SizedBox(width: 5),
                                              Text('${cm.likes}', style: context.text.cap.copyWith(color: c.ink3)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 14),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: c.hairline, width: .5))),
              child: Row(
                children: [
                  MnAvatar(name: context.read<AuthBloc>().state.user?.name ?? 'You', size: 34),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: c.surface3, borderRadius: BorderRadius.circular(22)),
                      child: TextField(
                        controller: _ctrl,
                        onSubmitted: (_) => _send(),
                        textInputAction: TextInputAction.send,
                        style: context.text.callout,
                        cursorColor: c.primary,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Add a kind comment…',
                          hintStyle: context.text.callout.copyWith(color: c.ink4),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  MnIconButton(
                    icon: MnIcons.send,
                    tooltip: 'Post comment',
                    iconSize: 18,
                    background: canSend ? c.primary : c.fill2,
                    color: canSend ? c.onPrimary : c.ink4,
                    onPressed: canSend ? _send : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
