import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../cubit/create_post_cubit.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key, this.postId});
  final String? postId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<CreatePostCubit>()..load(postId),
    child: _CreatePostView(editing: postId != null),
  );
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView({required this.editing});
  final bool editing;
  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  bool _seeded = false;
  static const topics = [
    'Anxiety',
    'Sleep',
    'Mindfulness',
    'Stress',
    'Relationships',
    'Growth',
  ];

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  bool get _canPublish =>
      _title.text.trim().isNotEmpty && _body.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        final cubit = context.read<CreatePostCubit>();
        // Seed controllers once from an edited post.
        if (!_seeded && state.seed != null) {
          _seeded = true;
          _title.text = state.seed!.title;
          _body.text =
              'Untangling the “I’m behind” feeling — a few reframes that help when the to-do list feels like proof you’re failing.';
        }

        if (state.published) {
          return MnScaffold(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SuccessCheck(),
                    const SizedBox(height: 24),
                    Text(
                      'Published',
                      style: MnText.title2.copyWith(color: c.ink),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 290),
                      child: Text(
                        'Your reflection is now live in Spaces for the people who need it.',
                        textAlign: TextAlign.center,
                        style: MnText.body.copyWith(color: c.ink2),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MnButton(
                      label: 'Back to content',
                      onPressed: () => context.goNamed(
                        RouteNames.proShell,
                        queryParameters: {'tab': 'content'},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final canPublish = _canPublish && state.topic != null;
        return MnScaffold(
          child: Column(
            children: [
              SizedBox(height: safeTop(context)),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
                child: Row(
                  children: [
                    NavBtn(icon: 'x', onTap: () => context.pop()),
                    Expanded(
                      child: Text(
                        widget.editing ? 'Edit post' : 'New post',
                        textAlign: TextAlign.center,
                        style: MnText.headline.copyWith(color: c.ink),
                      ),
                    ),
                    MnButton(
                      label: 'Save draft',
                      variant: MnVariant.secondary,
                      small: true,
                      expand: false,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                    children: [
                      GestureDetector(
                        onTap: cubit.toggleImage,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: state.hasImage ? 180 : 120,
                          decoration: BoxDecoration(
                            color: c.surface3,
                            borderRadius: BorderRadius.circular(18),
                            border: state.hasImage
                                ? null
                                : Border.all(color: c.hairline2, width: 1.5),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: state.hasImage
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    PhotoPlaceholder(
                                      '${state.topic ?? 'post'}cover',
                                      label: 'cover image',
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: const BoxDecoration(
                                          color: Color(0x80000000),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const MnIcon(
                                          'x',
                                          size: 16,
                                          color: Colors.white,
                                          stroke: 2.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: c.fill,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      alignment: Alignment.center,
                                      child: MnIcon(
                                        'image',
                                        size: 24,
                                        color: c.ink3,
                                        stroke: 1.8,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add a cover image',
                                      style: MnText.foot.copyWith(
                                        color: c.ink2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _title,
                        cursorColor: c.primary,
                        onChanged: (_) => setState(() {}),
                        style: MnText.serif(size: 26, color: c.ink),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Post title',
                          hintStyle: MnText.serif(size: 26, color: c.ink4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _body,
                        minLines: 6,
                        maxLines: null,
                        cursorColor: c.primary,
                        onChanged: (_) => setState(() {}),
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.6,
                          color: c.ink2,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Share something supportive…',
                          hintStyle: TextStyle(
                            fontSize: 17,
                            height: 1.6,
                            color: c.ink4,
                          ),
                        ),
                      ),
                      const Hairline(
                        margin: EdgeInsets.symmetric(vertical: 18),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          MnIcon('tag', size: 17, color: c.ink3, stroke: 1.9),
                          const SizedBox(width: 8),
                          Text(
                            'Topic',
                            style: MnText.headline.copyWith(
                              color: c.ink,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '· choose one',
                            style: MnText.foot.copyWith(color: c.ink3),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final t in topics)
                            TopicTag(
                              t,
                              active: state.topic == t,
                              onTap: () => cubit.selectTopic(t),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  22,
                  12,
                  22,
                  safeBottom(context) + 16,
                ),
                decoration: BoxDecoration(
                  color: c.bg,
                  border: Border(
                    top: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    MnIcon('globe', size: 16, color: c.ink3, stroke: 1.9),
                    const SizedBox(width: 7),
                    Text('Public', style: MnText.foot.copyWith(color: c.ink3)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MnButton(
                        label: 'Publish',
                        onPressed: canPublish ? cubit.publish : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
