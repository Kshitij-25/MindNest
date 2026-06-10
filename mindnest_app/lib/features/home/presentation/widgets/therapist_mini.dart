import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/features/discovery/domain/entities/therapist.dart';

/// Compact therapist card used in the Home "Recommended for you" rail.
class TherapistMini extends StatelessWidget {
  const TherapistMini({
    super.key,
    required this.therapist,
    required this.onTap,
  });
  final Therapist therapist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final t = therapist;
    return SizedBox(
      width: 168,
      child: MnCard(
        kind: MnCardKind.flat,
        onTap: onTap,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    height: 96,
                    width: double.infinity,
                    child: PhotoPlaceholder(t.name),
                  ),
                ),
                if (t.verified)
                  const Positioned(top: 8, right: 8, child: Verified(size: 18)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              t.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MnText.headline.copyWith(color: c.ink),
            ),
            const SizedBox(height: 2),
            Text(
              t.spec,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MnText.foot.copyWith(color: c.ink3),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Stars(t.rating, size: 12),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '· £${t.price}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MnText.foot.copyWith(color: c.ink3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
