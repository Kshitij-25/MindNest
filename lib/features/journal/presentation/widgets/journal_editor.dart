import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/journal_entry.dart';
import '../bloc/journal_editor_cubit.dart';
import 'journal_widgets.dart';

/// The writing surface: title, body, then a tools tray with mood, word
/// count and tags. Used full-screen on phones and inline on tablets.
class JournalEditor extends StatefulWidget {
  const JournalEditor({super.key, this.prompt, this.inline = false});

  final String? prompt;
  final bool inline;

  @override
  State<JournalEditor> createState() => _JournalEditorState();
}

class _JournalEditorState extends State<JournalEditor> {
  late final _title = TextEditingController(text: context.read<JournalEditorCubit>().state.entry.title);
  late final _body = TextEditingController(text: context.read<JournalEditorCubit>().state.entry.body);

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<JournalEditorCubit>();
    return BlocBuilder<JournalEditorCubit, JournalEditorState>(
      builder: (context, s) {
        final e = s.entry;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(widget.inline ? 40 : 24, widget.inline ? 32 : 10, widget.inline ? 40 : 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${widget.inline ? 'New entry' : 'Today'} · ${DateFormat('EEEE, d MMMM').format(e.createdAt)}',
                      style: context.text.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _title,
                      onChanged: cubit.setTitle,
                      textCapitalization: TextCapitalization.sentences,
                      style: context.text.serif(size: widget.inline ? 28 : 26),
                      cursorColor: c.primary,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: 'Give it a title…',
                        hintStyle: context.text.serif(size: widget.inline ? 28 : 26).copyWith(color: c.ink4),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _body,
                      onChanged: cubit.setBody,
                      autofocus: !widget.inline,
                      maxLines: null,
                      minLines: 9,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: context.text.body.copyWith(fontSize: 17, height: 1.65, color: c.ink2),
                      cursorColor: c.primary,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: widget.prompt ?? 'What’s present for you right now? There’s no wrong way to write here.',
                        hintStyle: context.text.body.copyWith(fontSize: 17, height: 1.65, color: c.ink4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, widget.inline ? 16 : MediaQuery.paddingOf(context).bottom + 16),
              decoration: BoxDecoration(
                color: c.paper,
                border: Border(top: BorderSide(color: c.hairline, width: .5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Pressable(
                        onTap: () async {
                          final m = await showMoodPickSheet(context, e.mood);
                          if (m != null) cubit.setMood(m);
                        },
                        semanticLabel: 'Mood: ${moodLabel(e.mood)}. Change mood',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: [
                              MoodFace(level: e.mood, size: 30),
                              const SizedBox(width: 8),
                              Text(moodLabel(e.mood), style: context.text.foot.copyWith(fontWeight: FontWeight.w600, color: c.ink)),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text('${e.wordCount} words', style: context.text.foot.copyWith(color: c.ink3)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final t in journalTags) ...[
                          JournalTag(tag: t, active: e.tags.contains(t), onTap: () => cubit.toggleTag(t)),
                          const SizedBox(width: 8),
                        ],
                      ],
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

/// "Entry saved" confirmation.
class JournalSavedView extends StatelessWidget {
  const JournalSavedView({super.key, required this.entry, required this.onDone});
  final JournalEntry entry;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SuccessCheck(color: c.primary, ring: c.primaryRing),
              const SizedBox(height: 24),
              FadeUp(child: Text('Entry saved', style: context.text.title2)),
              const SizedBox(height: 8),
              FadeUp(
                child: Text(
                  'That’s ${entry.wordCount} words just for you. Well held.',
                  textAlign: TextAlign.center,
                  style: context.text.body.copyWith(color: c.ink2),
                ),
              ),
              const SizedBox(height: 30),
              FadeUp(child: MnButton(label: 'Done', onPressed: onDone)),
            ],
          ),
        ),
      ),
    );
  }
}
