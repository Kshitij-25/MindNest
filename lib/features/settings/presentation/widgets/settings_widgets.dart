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
                Text('Free 24/7 helplines across India.', style: context.text.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w500)),
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

/// A 24/7 support line for users in India.
typedef Helpline = ({String name, String detail, String number, String display});

/// Crisis lines for India. Verify before each release — numbers do change.
const indiaHelplines = <Helpline>[
  (name: 'Tele-MANAS', detail: 'Government of India · 24/7 · 20+ languages', number: '14416', display: '14416'),
  (name: 'Vandrevala Foundation', detail: '24/7 · call or WhatsApp', number: '+919999666555', display: '+91 99996 66555'),
  (name: 'AASRA', detail: '24/7 · suicide prevention', number: '+919820466726', display: '+91 98204 66726'),
  (name: 'Emergency services', detail: 'Police, ambulance, fire', number: '112', display: '112'),
];

/// Lists [indiaHelplines]; tapping one opens the phone dialler.
Future<void> showCrisisSheet(BuildContext context) => showMnSheet<void>(
  context,
  builder: (ctx) {
    final c = ctx.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('You’re not alone', style: ctx.text.title3),
            const SizedBox(height: 4),
            Text(
              'These free, confidential lines are open right now. If you’re in immediate danger, call 112.',
              style: ctx.text.foot.copyWith(color: c.ink2),
            ),
            const SizedBox(height: 14),
            for (final h in indiaHelplines)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MnCard(
                  style: MnCardStyle.inset,
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                  onTap: () => ExternalLinks.open(ctx, Uri(scheme: 'tel', path: h.number)),
                  semanticLabel: 'Call ${h.name}, ${h.display}',
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(h.name, style: ctx.text.headline),
                            Text(h.detail, style: ctx.text.cap.copyWith(color: c.ink3)),
                          ],
                        ),
                      ),
                      Text(h.display, style: ctx.text.callout.copyWith(color: c.clay, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 10),
                      IconTile(size: 36, radius: 10, color: c.clay, child: const MnIcon(MnIcons.phone, size: 17, color: Colors.white)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  },
);
