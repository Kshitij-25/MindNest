import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'mn_icon.dart';
import 'pressable.dart';

/// Pill chip (`.chip`, `.chip.active`, `.chip.outline`).
class MnChip extends StatelessWidget {
  const MnChip({
    super.key,
    required this.label,
    this.selected = false,
    this.outline = false,
    this.onTap,
    this.icon,
    this.large = false,
    this.dotColor,
  });

  final String label;
  final bool selected;
  final bool outline;
  final VoidCallback? onTap;
  final MnIconData? icon;
  final bool large;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = selected ? c.onPrimary : c.ink2;
    return Semantics(
      selected: selected,
      button: onTap != null,
      child: Pressable(
        onTap: onTap,
        scale: 0.95,
        child: AnimatedScale(
          scale: selected && large ? 1.03 : 1,
          duration: MnMotion.base,
          curve: MnMotion.easeSpring,
          child: AnimatedContainer(
            duration: MnMotion.base,
            curve: MnMotion.ease,
            height: large ? 44 : 36,
            padding: EdgeInsets.symmetric(horizontal: large ? 18 : 15),
            decoration: BoxDecoration(
              color: selected ? c.primary : (outline ? Colors.transparent : c.fill),
              borderRadius: BorderRadius.circular(MnRadii.pill),
              border: Border.all(color: outline && !selected ? c.hairline2 : Colors.transparent, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dotColor != null) ...[
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
                  const SizedBox(width: 7),
                ],
                if (icon != null) ...[MnIcon(icon!, size: 15, stroke: 3, color: fg), const SizedBox(width: 6)],
                Text(
                  label,
                  style: TextStyle(color: fg, fontSize: large ? 15 : 14, fontWeight: FontWeight.w600, letterSpacing: -0.14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontally scrolling row of chips.
class MnChipRow extends StatelessWidget {
  const MnChipRow({super.key, required this.children, this.padding});

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? EdgeInsets.symmetric(horizontal: context.gutter),
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            children[i],
          ],
        ],
      ),
    );
  }
}

enum MnBadgeTone { verify, pending, accept, reject, neutral, clay }

/// Small status pill (`.badge-*`).
class MnBadge extends StatelessWidget {
  const MnBadge({super.key, required this.label, this.tone = MnBadgeTone.verify, this.icon});

  final String label;
  final MnBadgeTone tone;
  final MnIconData? icon;

  /// Maps booking/post statuses to tones.
  factory MnBadge.status(String status) {
    final tone = switch (status.toLowerCase()) {
      'accepted' || 'confirmed' || 'published' || 'paid' || 'completed' => MnBadgeTone.accept,
      'pending' || 'draft' || 'in review' || 'processing' => MnBadgeTone.pending,
      'declined' || 'rejected' || 'cancelled' => MnBadgeTone.reject,
      _ => MnBadgeTone.neutral,
    };
    return MnBadge(label: status, tone: tone);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (Color bg, Color fg) = switch (tone) {
      MnBadgeTone.verify => (c.primaryTint, c.primary),
      MnBadgeTone.pending => (c.amber.withValues(alpha: .16), c.amber),
      MnBadgeTone.accept => (c.green.withValues(alpha: .16), c.green),
      MnBadgeTone.reject => (c.red.withValues(alpha: .16), c.red),
      MnBadgeTone.neutral => (c.fill, c.ink2),
      MnBadgeTone.clay => (c.clayTint, c.clay),
    };
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(MnRadii.pill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[MnIcon(icon!, size: 12, color: fg, stroke: 2.4), const SizedBox(width: 4)],
          Text(label, style: TextStyle(color: fg, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: .1)),
        ],
      ),
    );
  }
}

/// Topic tag with coloured dot (journal/feed).
class TopicTag extends StatelessWidget {
  const TopicTag({super.key, required this.label, required this.color, this.small = false});

  final String label;
  final Color color;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: small ? 22 : 26,
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(MnRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontSize: small ? 11.5 : 12.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
