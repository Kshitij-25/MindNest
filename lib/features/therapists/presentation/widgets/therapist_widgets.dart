import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/therapist.dart';

/// Diagonal-striped portrait placeholder tinted by name (`PhotoPlaceholder`).
class PortraitPlaceholder extends StatelessWidget {
  const PortraitPlaceholder({super.key, required this.name, this.radius = 0});
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final hue = avatarHue(name);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CustomPaint(
        painter: _StripePainter(hue),
        child: LayoutBuilder(
          builder: (context, box) {
            final s = box.biggest.shortestSide * .38;
            return Center(
              child: Container(
                width: s,
                height: s,
                decoration: BoxDecoration(color: hue.withValues(alpha: .33), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: MnIcon(MnIcons.user, size: s * .6, color: hue, stroke: 1.6),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter(this.hue);
  final Color hue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = hue.withValues(alpha: .13));
    final p = Paint()
      ..color = hue.withValues(alpha: .07)
      ..strokeWidth = 8;
    for (double x = -size.height; x < size.width + size.height; x += 16) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), p);
    }
  }

  @override
  bool shouldRepaint(_StripePainter old) => old.hue != hue;
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) => Container(
        width: 3,
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: context.colors.ink4, shape: BoxShape.circle),
      );
}

class OutlineTag extends StatelessWidget {
  const OutlineTag({super.key, required this.label, this.icon, this.height = 28});
  final String label;
  final MnIconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.hairline2, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[MnIcon(icon!, size: 15, color: c.ink3, stroke: 1.9), const SizedBox(width: 6)],
          Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: c.ink2)),
        ],
      ),
    );
  }
}

/// Full discover card (`TherapistCard`).
class TherapistCard extends StatelessWidget {
  const TherapistCard({super.key, required this.therapist, required this.onTap, this.onToggleSaved});

  final Therapist therapist;
  final VoidCallback onTap;
  final VoidCallback? onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = therapist;
    return MnCard(
      onTap: onTap,
      semanticLabel: '${t.name}, ${t.title}',
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 72, height: 72, child: PortraitPlaceholder(name: t.name, radius: 18)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(t.name, style: context.text.headline, maxLines: 1, overflow: TextOverflow.ellipsis)),
                        if (t.verified) ...[const SizedBox(width: 6), const VerifiedBadge(size: 15)],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(t.title, style: context.text.callout.copyWith(color: c.ink2)),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        MnRating(value: t.rating, size: 12),
                        const SizedBox(width: 6),
                        Text('(${t.reviewCount})', style: context.text.foot.copyWith(color: c.ink3)),
                        const _Dot(),
                        Text('${t.years} yrs', style: context.text.foot.copyWith(color: c.ink3)),
                      ],
                    ),
                  ],
                ),
              ),
              MnIconButton(
                icon: MnIcons.bookmark,
                tooltip: t.saved ? 'Remove from saved' : 'Save therapist',
                size: 34,
                iconSize: 17,
                stroke: 1.8,
                color: t.saved ? c.primary : c.ink3,
                background: t.saved ? c.primaryTint : c.fill,
                onPressed: onToggleSaved,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(spacing: 6, runSpacing: 6, children: [for (final tag in t.tags.take(3)) OutlineTag(label: tag)]),
          const Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Hairline()),
          Row(
            children: [
              MnIcon(MnIcons.clock, size: 16, color: c.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Next: ${t.nextAvailable}',
                  style: context.text.foot.copyWith(color: c.green, fontWeight: FontWeight.w600),
                ),
              ),
              Text('£${t.price}', style: context.text.headline),
              Text(' /session', style: context.text.foot.copyWith(color: c.ink3)),
              const SizedBox(width: 10),
              MnButton(label: 'View', size: MnButtonSize.small, expand: false, onPressed: onTap),
            ],
          ),
        ],
      ),
    );
  }
}

/// Compact horizontal-scroll card (`TherapistMini`).
class TherapistMiniCard extends StatelessWidget {
  const TherapistMiniCard({super.key, required this.therapist, required this.onTap, this.width = 168});

  final Therapist therapist;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = therapist;
    return SizedBox(
      width: width,
      child: MnCard(
        style: MnCardStyle.flat,
        onTap: onTap,
        semanticLabel: t.name,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PortraitPlaceholder(name: t.name, radius: 16),
                  if (t.verified)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle, boxShadow: MnShadows.sm(c)),
                        child: const VerifiedBadge(size: 15),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(t.name, style: context.text.headline, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(t.specialty, style: context.text.foot.copyWith(color: c.ink2), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              children: [
                MnRating(value: t.rating, size: 12),
                Text('  · £${t.price}', style: context.text.foot.copyWith(color: c.ink3)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tablet "Find your therapist" card.
class TherapistGridCard extends StatelessWidget {
  const TherapistGridCard({super.key, required this.therapist, required this.onTap});
  final Therapist therapist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = therapist;
    return MnCard(
      style: MnCardStyle.flat,
      radius: 20,
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MnAvatar(name: t.name, size: 46, photo: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name, style: context.text.sub.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(t.specialty, style: context.text.cap.copyWith(color: c.ink3), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              MnRating(value: t.rating, size: 12),
              const Spacer(),
              Text('Next: ${t.nextAvailable}', style: context.text.cap.copyWith(color: c.primary, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small therapist summary row used on booking screens.
class TherapistSummaryRow extends StatelessWidget {
  const TherapistSummaryRow({super.key, required this.therapist, this.trailing});
  final Therapist therapist;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return MnCard(
      style: MnCardStyle.flat,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          SizedBox(width: 48, height: 48, child: PortraitPlaceholder(name: therapist.name, radius: 14)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(therapist.name, style: context.text.headline),
                Text(therapist.specialty, style: context.text.foot.copyWith(color: context.colors.ink2)),
              ],
            ),
          ),
          trailing ?? MnRating(value: therapist.rating),
        ],
      ),
    );
  }
}
