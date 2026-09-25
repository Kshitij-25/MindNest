import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../feed/domain/entities/post.dart';
import '../bloc/content_cubit.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key, this.postId});
  final String? postId;

  @override
  Widget build(BuildContext context) {
    final existing = postId == null ? null : getIt<ContentCubit>().state.posts.where((p) => p.id == postId).firstOrNull;
    return BlocProvider(
      create: (_) => getIt<CreatePostCubit>()..start(existing),
      child: _Editor(editing: existing != null),
    );
  }
}

class _Editor extends StatefulWidget {
  const _Editor({required this.editing});
  final bool editing;

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  late final _title = TextEditingController(text: context.read<CreatePostCubit>().state.post.title);
  late final _body = TextEditingController(text: context.read<CreatePostCubit>().state.post.body);

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      listenWhen: (a, b) => a.error != b.error && b.error != null,
      listener: (context, s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.error!))),
      builder: (context, s) {
        final cubit = context.read<CreatePostCubit>();
        if (s.published != null) {
          final draft = s.published!.status == PostStatus.draft;
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SuccessCheck(color: c.primary, ring: c.primaryRing),
                      const SizedBox(height: 24),
                      FadeUp(child: Text(draft ? 'Draft saved' : 'Published', style: context.text.title2)),
                      const SizedBox(height: 8),
                      FadeUp(
                        child: Text(
                          draft ? 'Pick it back up whenever it feels ready.' : 'Your reflection is now live in Spaces for the people who need it.',
                          textAlign: TextAlign.center,
                          style: context.text.body.copyWith(color: c.ink2),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeUp(child: MnButton(label: 'Back to content', onPressed: () => context.router.maybePop())),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        final p = s.post;
        return MnPage(
          maxWidth: 720,
          header: MnNavHeader(
            title: widget.editing ? 'Edit post' : 'New post',
            leading: MnIconButton(icon: MnIcons.x, tooltip: 'Close', onPressed: () => context.router.maybePop()),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: MnButton.secondary(
                label: 'Save draft',
                size: MnButtonSize.small,
                expand: false,
                onPressed: s.submitting ? null : () => cubit.submit(asDraft: true),
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Pressable(
                onTap: cubit.toggleImage,
                semanticLabel: p.hasImage ? 'Remove cover image' : 'Add a cover image',
                child: AnimatedContainer(
                  duration: MnMotion.base,
                  height: p.hasImage ? 180 : 120,
                  decoration: BoxDecoration(
                    color: c.surface3,
                    borderRadius: BorderRadius.circular(18),
                    border: p.hasImage ? null : Border.all(color: c.hairline2, width: 1.5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: p.hasImage
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            MnImagePlaceholder(seed: p.topic.length, height: 180, radius: 18),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(color: Colors.black.withValues(alpha: .5), shape: BoxShape.circle),
                                child: const MnIcon(MnIcons.x, size: 16, color: Colors.white, stroke: 2.4),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconTile(size: 46, radius: 14, color: c.fill, child: MnIcon(MnIcons.image, size: 24, color: c.ink3, stroke: 1.8)),
                            const SizedBox(height: 8),
                            Text('Add a cover image', style: context.text.foot.copyWith(fontWeight: FontWeight.w600, color: c.ink2)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _title,
                onChanged: cubit.setTitle,
                textCapitalization: TextCapitalization.sentences,
                style: context.text.serif(size: 26),
                cursorColor: c.primary,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: 'Post title',
                  hintStyle: context.text.serif(size: 26).copyWith(color: c.ink4),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _body,
                onChanged: cubit.setBody,
                minLines: 7,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: context.text.body.copyWith(fontSize: 17, height: 1.6, color: c.ink2),
                cursorColor: c.primary,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: 'Share something supportive…',
                  hintStyle: context.text.body.copyWith(fontSize: 17, color: c.ink4),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 18), child: Hairline()),
              Row(
                children: [
                  MnIcon(MnIcons.tag, size: 17, color: c.ink3),
                  const SizedBox(width: 8),
                  Text('Topic', style: context.text.headline.copyWith(fontSize: 15)),
                  Text('  · choose one', style: context.text.foot.copyWith(color: c.ink3)),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in postTopics)
                    Semantics(
                      selected: p.topic == t,
                      button: true,
                      child: Pressable(
                        onTap: () => cubit.setTopic(t),
                        scale: .95,
                        child: AnimatedContainer(
                          duration: MnMotion.base,
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: p.topic == t ? topicColor(c, t) : topicColor(c, t).withValues(alpha: .14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(color: p.topic == t ? Colors.white : topicColor(c, t), shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(t, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: p.topic == t ? Colors.white : topicColor(c, t))),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              MergeSemantics(
                child: Row(
                  children: [
                    Expanded(child: Text('Allow comments', style: context.text.body)),
                    MnToggle(value: p.allowComments, onChanged: (_) => cubit.toggleComments()),
                  ],
                ),
              ),
            ],
          ),
          bottom: Row(
            children: [
              MnIcon(MnIcons.globe, size: 16, color: c.ink3),
              const SizedBox(width: 7),
              Text('Public', style: context.text.foot.copyWith(color: c.ink3)),
              const SizedBox(width: 12),
              Expanded(child: MnButton(label: 'Publish', loading: s.submitting, onPressed: s.canPublish ? () => cubit.submit() : null)),
            ],
          ),
        );
      },
    );
  }
}
