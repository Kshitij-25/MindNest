import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/shared/helpers/formatters.dart';

import '../../domain/entities/journal_entry.dart';
import '../cubit/journal_write_cubit.dart';

class JournalWritePage extends StatelessWidget {
  const JournalWritePage({super.key, this.entry});
  final JournalEntry? entry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<JournalWriteCubit>()..init(entry),
      child: _JournalWriteView(entry: entry),
    );
  }
}

class _JournalWriteView extends StatefulWidget {
  const _JournalWriteView({this.entry});
  final JournalEntry? entry;
  @override
  State<_JournalWriteView> createState() => _JournalWriteViewState();
}

class _JournalWriteViewState extends State<_JournalWriteView> {
  late final _title = TextEditingController(text: widget.entry?.title ?? '');
  late final _body = TextEditingController(text: widget.entry?.body ?? '');
  static const allTags = [
    'Calm',
    'Gratitude',
    'Stress',
    'Sleep',
    'Growth',
    'Therapy',
    'Self-care',
    'Anxiety',
  ];

  @override
  void initState() {
    super.initState();
    _body.addListener(() => context.read<JournalWriteCubit>().setWords(_words));
  }

  int get _words => _body.text.trim().isEmpty
      ? 0
      : _body.text.trim().split(RegExp(r'\s+')).length;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<JournalWriteCubit>();
    return BlocBuilder<JournalWriteCubit, JournalWriteState>(
      builder: (context, state) {
        if (state.saved) {
          return MnScaffold(
            background: c.paper,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SuccessCheck(),
                    const SizedBox(height: 24),
                    Text(
                      'Entry saved',
                      style: MnText.title2.copyWith(color: c.ink),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Text(
                        'That’s ${state.words} words just for you. Well held.',
                        textAlign: TextAlign.center,
                        style: MnText.body.copyWith(color: c.ink2),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MnButton(
                      label: 'Done',
                      expand: false,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        final today = Formatters.mediumDate(context, DateTime.now());
        return MnScaffold(
          background: c.paper,
          child: Column(
            children: [
              SizedBox(height: safeTop(context)),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
                child: Row(
                  children: [
                    NavBtn(icon: 'chevDown', onTap: () => context.pop()),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: c.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Draft autosaved',
                            style: MnText.cap.copyWith(color: c.ink3),
                          ),
                        ],
                      ),
                    ),
                    MnButton(
                      label: 'Save',
                      small: true,
                      expand: false,
                      onPressed: _body.text.trim().isEmpty
                          ? null
                          : () => cubit.save(_title.text, _body.text),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
                    children: [
                      Text(
                        'Today · $today',
                        style: MnText.foot.copyWith(
                          color: c.ink3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _title,
                        cursorColor: c.primary,
                        style: MnText.serif(size: 26, color: c.ink),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Give it a title…',
                          hintStyle: MnText.serif(size: 26, color: c.ink4),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _body,
                        autofocus: true,
                        minLines: 9,
                        maxLines: null,
                        cursorColor: c.primary,
                        onChanged: (_) => setState(() {}),
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.65,
                          color: c.ink2,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText:
                              'What’s present for you right now? There’s no wrong way to write here.',
                          hintStyle: TextStyle(
                            fontSize: 17,
                            height: 1.65,
                            color: c.ink4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  safeBottom(context) + 12,
                ),
                decoration: BoxDecoration(
                  color: c.paper,
                  border: Border(
                    top: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.tags.isNotEmpty) ...[
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [for (final t in state.tags) TopicTag(t)],
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _pickMood(context, cubit, state.mood),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: c.fill,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MoodFace(level: state.mood, size: 30),
                                const SizedBox(width: 8),
                                Text(
                                  moodLabels[state.mood - 1],
                                  style: MnText.foot.copyWith(
                                    color: c.ink,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$_words words',
                          style: MnText.foot.copyWith(color: c.ink3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 32,
                      child: NoGlow(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: allTags.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (_, i) => TopicTag(
                            allTags[i],
                            active: state.tags.contains(allTags[i]),
                            onTap: () => cubit.toggleTag(allTags[i]),
                          ),
                        ),
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

  void _pickMood(BuildContext context, JournalWriteCubit cubit, int current) {
    showMnSheet(context, (sheetCtx) {
      final c = sheetCtx.c;
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: SheetGrab()),
            Text(
              'How are you feeling?',
              style: MnText.title3.copyWith(color: c.ink),
            ),
            const SizedBox(height: 6),
            Text(
              'Tag this entry with a mood.',
              style: MnText.callout.copyWith(color: c.ink2),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var l = 1; l <= 5; l++)
                  GestureDetector(
                    onTap: () {
                      cubit.setMood(l);
                      Navigator.pop(sheetCtx);
                    },
                    child: AnimatedOpacity(
                      opacity: current == l ? 1 : 0.55,
                      duration: const Duration(milliseconds: 150),
                      child: Column(
                        children: [
                          MoodFace(level: l, size: 52),
                          const SizedBox(height: 8),
                          Text(
                            moodLabels[l - 1],
                            style: MnText.cap.copyWith(
                              color: c.ink3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
