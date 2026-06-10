import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../../domain/entities/journal_entry.dart';

class JournalRow extends StatelessWidget {
  const JournalRow({super.key, required this.entry, required this.onTap});
  final JournalEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final j = entry;
    return MnCard(
      kind: MnCardKind.flat,
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 2),
              MoodFace(level: j.mood, size: 44),
              const SizedBox(height: 6),
              Text(
                j.date,
                style: MnText.cap.copyWith(
                  color: c.ink3,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                        j.displayTitle,
                        style: MnText.serif(size: 18, color: c.ink),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (j.draft) ...[
                      const SizedBox(width: 8),
                      const Badge2('Draft', kind: BadgeKind.pending),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  j.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MnText.callout.copyWith(color: c.ink2, height: 1.45),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final t in j.tags) TopicTag(t, sm: true)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
