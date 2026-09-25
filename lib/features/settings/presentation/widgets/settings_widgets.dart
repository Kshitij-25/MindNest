import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SettingIcon extends StatelessWidget {
  const SettingIcon({super.key, required this.icon, this.color});
  final MnIconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) => IconTile(
        size: 32,
        radius: 9,
        color: color?.withValues(alpha: .14),
        child: MnIcon(icon, size: 17, color: color ?? context.colors.primary, stroke: 1.9),
      );
}

/// Accessibility / preference toggle card (`ToggleCard`).
class ToggleCard extends StatelessWidget {
  const ToggleCard({super.key, required this.icon, required this.title, required this.subtitle, required this.value, required this.onChanged});
  final MnIconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      radius: 22,
      padding: const EdgeInsets.all(20),
      child: MergeSemantics(
        child: Row(
          children: [
            AnimatedContainer(
              duration: MnMotion.base,
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: value ? c.primaryTint : c.fill, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: MnIcon(icon, size: 21, color: value ? c.primary : c.ink3),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.text.headline),
                  const SizedBox(height: 2),
                  Text(subtitle, style: context.text.sub.copyWith(color: c.ink3)),
                ],
              ),
            ),
            MnToggle(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

/// "In crisis?" support card.
class CrisisCard extends StatelessWidget {
  const CrisisCard({super.key, required this.onCall});
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      color: c.clayTint,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          IconTile(size: 40, radius: 12, color: c.clay, child: const MnIcon(MnIcons.phone, size: 20, color: Colors.white)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('In crisis? You’re not alone', style: context.text.foot.copyWith(fontWeight: FontWeight.w700, color: c.ink)),
                const SizedBox(height: 2),
                Text('Reach 24/7 confidential support now.', style: context.text.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Pressable(
            onTap: onCall,
            semanticLabel: 'Call crisis support',
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: c.clay, borderRadius: BorderRadius.circular(MnRadii.xs)),
              child: const Text('Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
