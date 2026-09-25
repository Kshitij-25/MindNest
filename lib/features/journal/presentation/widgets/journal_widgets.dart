import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/journal_entry.dart';

String journalDay(DateTime d) {
  final now = DateTime.now();
  final diff = DateTime(now.year, now.month, now.day).difference(DateTime(d.year, d.month, d.day)).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  return DateFormat.E().format(d);
}

/// Topic tag with dot; optionally selectable (`TopicTag`).
class JournalTag extends StatelessWidget {
  const JournalTag({super.key, required this.tag, this.small = false, this.active = false, this.onTap});
  final String tag;
  final bool small;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final col = topicColor(context.colors, tag);
    final child = AnimatedContainer(
      duration: MnMotion.base,
      height: small ? 24 : 32,
      padding: EdgeInsets.symmetric(horizontal: small ? 9 : 13),
      decoration: BoxDecoration(
        color: active ? col : col.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: small ? 5 : 6,
            height: small ? 5 : 6,
            decoration: BoxDecoration(color: active ? Colors.white : col, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            tag,
            style: TextStyle(fontSize: small ? 12 : 13.5, fontWeight: FontWeight.w600, color: active ? Colors.white : col),
          ),
        ],
      ),
    );
    if (onTap == null) return child;
    return Semantics(selected: active, button: true, child: Pressable(onTap: onTap, scale: .95, child: child));
  }
}

class JournalRow extends StatelessWidget {
  const JournalRow({super.key, required this.entry, required this.onTap, this.selected = false, this.compact = false});
  final JournalEntry entry;
  final VoidCallback onTap;
  final bool selected;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final e = entry;
    if (compact) {
      // Tablet split-list row.
      return Pressable(
        onTap: onTap,
        scale: .98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? c.primaryTint : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MoodFace(level: e.mood, size: 30),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${journalDay(e.createdAt)} · ${DateFormat.jm().format(e.createdAt)}',
                      style: context.text.cap.copyWith(color: c.ink3),
                    ),
                  ),
                  if (e.draft) const MnBadge(label: 'Draft', tone: MnBadgeTone.pending),
                  if (e.favourite && !e.draft) MnIcon(MnIcons.star, size: 14, color: c.streak, filled: true, stroke: .01),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                e.displayTitle,
                style: context.text.sub.copyWith(fontWeight: FontWeight.w700, color: selected ? c.primary : c.ink),
              ),
              const SizedBox(height: 3),
              Text(e.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w400, height: 1.4)),
            ],
          ),
        ),
      );
    }
    return MnCard(
      style: MnCardStyle.flat,
      onTap: onTap,
      semanticLabel: e.displayTitle,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              MoodFace(level: e.mood, size: 44),
              const SizedBox(height: 6),
              Text(DateFormat('d MMM').format(e.createdAt), style: context.text.cap.copyWith(color: c.ink3)),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.displayTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.serif(size: 18, height: 1.3),
                      ),
                    ),
                    if (e.draft) const MnBadge(label: 'Draft', tone: MnBadgeTone.pending),
                  ],
                ),
                const SizedBox(height: 5),
                Text(e.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.callout.copyWith(color: c.ink2, height: 1.45)),
                if (e.tags.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(spacing: 6, runSpacing: 6, children: [for (final t in e.tags) JournalTag(tag: t, small: true)]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Month grid tinted by each day's mood.
class JournalCalendar extends StatelessWidget {
  const JournalCalendar({
    super.key,
    required this.month,
    required this.byDay,
    required this.onPick,
    required this.onMonthChanged,
  });

  final DateTime month;
  final Map<int, JournalEntry> byDay;
  final ValueChanged<JournalEntry> onPick;
  final ValueChanged<int> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final first = DateTime(month.year, month.month);
    final daysIn = DateTime(month.year, month.month + 1, 0).day;
    final pad = first.weekday % 7; // Sunday-first grid
    final cells = <int?>[...List.filled(pad, null), for (var d = 1; d <= daysIn; d++) d];
    final now = DateTime.now();
    final canNext = month.isBefore(DateTime(now.year, now.month));
    return Column(
      children: [
        MnCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text(DateFormat.yMMMM().format(month), style: context.text.title3)),
                  MnIconButton(icon: MnIcons.chevL, tooltip: 'Previous month', size: 32, iconSize: 16, onPressed: () => onMonthChanged(-1)),
                  const SizedBox(width: 6),
                  MnIconButton(
                    icon: MnIcons.chevR,
                    tooltip: 'Next month',
                    size: 32,
                    iconSize: 16,
                    onPressed: canNext ? () => onMonthChanged(1) : null,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  for (final d in const ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                    Expanded(child: Text(d, textAlign: TextAlign.center, style: context.text.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700))),
                ],
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  for (final d in cells)
                    if (d == null)
                      const SizedBox()
                    else
                      Builder(builder: (context) {
                        final e = byDay[d];
                        return Semantics(
                          label: '${DateFormat.MMMMd().format(DateTime(month.year, month.month, d))}${e == null ? '' : ', ${moodLabel(e.mood)}'}',
                          button: e != null,
                          excludeSemantics: true,
                          child: Pressable(
                            onTap: e == null ? null : () => onPick(e),
                            child: Container(
                              decoration: BoxDecoration(
                                color: e == null ? Colors.transparent : Color.alphaBlend(c.mood(e.mood).withValues(alpha: .22), c.surface),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$d', style: context.text.foot.copyWith(fontWeight: FontWeight.w600, color: e == null ? c.ink4 : c.ink)),
                                  if (e != null) ...[
                                    const SizedBox(height: 2),
                                    Container(width: 6, height: 6, decoration: BoxDecoration(color: c.mood(e.mood), shape: BoxShape.circle)),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final l in const [1, 3, 5]) ...[
              Container(width: 8, height: 8, decoration: BoxDecoration(color: c.mood(l), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text(moodLabel(l), style: context.text.cap.copyWith(color: c.ink3)),
              const SizedBox(width: 14),
            ],
          ],
        ),
      ],
    );
  }
}

/// Read-only entry content (shared by phone page and tablet split pane).
class JournalEntryContent extends StatelessWidget {
  const JournalEntryContent({super.key, required this.entry, this.large = false});
  final JournalEntry entry;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final e = entry;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeUp(
          child: Row(
            children: [
              MoodFace(level: e.mood, size: large ? 44 : 52),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(large ? 'Feeling ${moodLabel(e.mood).toLowerCase()}' : moodLabel(e.mood), style: context.text.headline),
                  Text(
                    '${journalDay(e.createdAt)} · ${DateFormat('d MMM').format(e.createdAt)} · ${DateFormat.jm().format(e.createdAt)}',
                    style: context.text.foot.copyWith(color: c.ink3),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FadeUp(
          delay: const Duration(milliseconds: 60),
          child: Text(e.displayTitle, style: context.text.serif(size: large ? 32 : 30, height: 1.15)),
        ),
        const SizedBox(height: 18),
        FadeUp(
          delay: const Duration(milliseconds: 120),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(e.body, style: context.text.body.copyWith(fontSize: 17, height: 1.7, color: c.ink2)),
          ),
        ),
        if (e.tags.isNotEmpty) ...[
          const SizedBox(height: 24),
          Wrap(spacing: 8, runSpacing: 8, children: [for (final t in e.tags) JournalTag(tag: t)]),
        ],
        const Padding(padding: EdgeInsets.fromLTRB(0, 28, 0, 16), child: Hairline()),
        Row(
          children: [
            MnIcon(MnIcons.lock, size: 15, color: c.ink3),
            const SizedBox(width: 8),
            Text('Private · only visible to you', style: context.text.foot.copyWith(color: c.ink3)),
          ],
        ),
      ],
    );
  }
}

/// Mood picker sheet for tagging an entry.
Future<int?> showMoodPickSheet(BuildContext context, int current) => showMnSheet<int>(
      context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('How are you feeling?', style: ctx.text.title3),
            const SizedBox(height: 6),
            Text('Tag this entry with a mood.', style: ctx.text.callout.copyWith(color: ctx.colors.ink2)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var l = 1; l <= 5; l++)
                  Pressable(
                    onTap: () => Navigator.pop(ctx, l),
                    semanticLabel: moodLabel(l),
                    child: AnimatedOpacity(
                      opacity: current == l ? 1 : .55,
                      duration: MnMotion.base,
                      child: Column(
                        children: [
                          MoodFace(level: l, size: 52),
                          const SizedBox(height: 8),
                          Text(moodLabel(l), style: ctx.text.cap.copyWith(color: ctx.colors.ink3)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
