import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../cubit/comments_cubit.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key, required this.postId});
  final String postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CommentsCubit>()..load(postId),
      child: const _CommentSheetView(),
    );
  }
}

class _CommentSheetView extends StatefulWidget {
  const _CommentSheetView();
  @override
  State<_CommentSheetView> createState() => _CommentSheetViewState();
}

class _CommentSheetViewState extends State<_CommentSheetView> {
  final _input = TextEditingController();
  final _likes = <String, bool>{};

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send() {
    context.read<CommentsCubit>().add(_input.text);
    _input.clear();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
              child: Column(
                children: [
                  const SheetGrab(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Comments · ${state.comments.length}',
                          style: MnText.title3.copyWith(color: c.ink),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: MnIcon('x', size: 22, color: c.ink3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Hairline(),
            Flexible(
              child: NoGlow(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                  children: [
                    for (final cm in state.comments)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Avatar(cm.name, size: 36),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c.surface3,
                                      borderRadius: BorderRadius.circular(
                                        MnRadius.md,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              cm.name,
                                              style: MnText.foot.copyWith(
                                                color: c.ink,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              cm.time,
                                              style: MnText.cap.copyWith(
                                                color: c.ink3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          cm.text,
                                          style: MnText.callout.copyWith(
                                            color: c.ink2,
                                            height: 1.45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(
                                      () => _likes[cm.id] =
                                          !(_likes[cm.id] ?? false),
                                    ),
                                    behavior: HitTestBehavior.opaque,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        6,
                                        6,
                                        6,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MnIcon(
                                            'heart',
                                            size: 14,
                                            color: (_likes[cm.id] ?? false)
                                                ? c.red
                                                : c.ink3,
                                            fill: (_likes[cm.id] ?? false)
                                                ? c.red
                                                : null,
                                            stroke: 1.9,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${cm.likes + ((_likes[cm.id] ?? false) ? 1 : 0)}',
                                            style: MnText.cap.copyWith(
                                              color: c.ink3,
                                            ),
                                          ),
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
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                16,
                10,
                16,
                MediaQuery.of(context).viewInsets.bottom + 14,
              ),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
              ),
              child: Row(
                children: [
                  const Avatar('Maya L.', size: 34),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: c.surface3,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _input,
                        cursorColor: c.primary,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        style: MnText.callout.copyWith(color: c.ink),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 11,
                          ),
                          border: InputBorder.none,
                          hintText: 'Add a kind comment…',
                          hintStyle: MnText.callout.copyWith(color: c.ink4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: c.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: MnIcon(
                        'send',
                        size: 18,
                        color: c.onPrimary,
                        stroke: 2,
                      ),
                    ),
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
