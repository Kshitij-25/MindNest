import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Bell button with unread dot.
class BellButton extends StatelessWidget {
  const BellButton({super.key, required this.hasUnread, required this.onTap, this.square = false});
  final bool hasUnread;
  final VoidCallback onTap;
  final bool square;

  @override
  Widget build(BuildContext context) => MnIconButton(
        icon: MnIcons.bell,
        tooltip: hasUnread ? 'Notifications, unread' : 'Notifications',
        iconSize: 21,
        stroke: 1.9,
        square: square,
        size: square ? 44 : 40,
        badge: hasUnread,
        onPressed: onTap,
      );
}

String greeting() {
  final h = DateTime.now().hour;
  if (h < 12) return 'Good morning';
  if (h < 18) return 'Good afternoon';
  return 'Good evening';
}

/// Quick action tile (Track mood / Journal / Find care).
class QuickAction extends StatelessWidget {
  const QuickAction({super.key, required this.icon, required this.label, required this.onTap});
  final MnIconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      style: MnCardStyle.flat,
      onTap: onTap,
      semanticLabel: label,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          IconTile(size: 44, radius: 14, child: MnIcon(icon, size: 22, color: c.primary, stroke: 1.9)),
          const SizedBox(height: 9),
          Text(label, style: context.text.foot.copyWith(color: c.ink, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Journal nudge card with gradient.
class ReflectionPrompt extends StatelessWidget {
  const ReflectionPrompt({super.key, required this.prompt, required this.onTap});
  final String prompt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      style: MnCardStyle.flat,
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      gradient: LinearGradient(colors: [c.primaryTint, c.surface], stops: const [0, .8]),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(14), boxShadow: MnShadows.sm(c)),
            alignment: Alignment.center,
            child: MnIcon(MnIcons.feather, size: 22, color: c.primary, stroke: 1.7),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today’s reflection', style: context.text.headline),
                const SizedBox(height: 2),
                Text('“$prompt”', style: context.text.foot.copyWith(color: c.ink2)),
              ],
            ),
          ),
          MnIcon(MnIcons.chevR, size: 20, color: c.ink4),
        ],
      ),
    );
  }
}
