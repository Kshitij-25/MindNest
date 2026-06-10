import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

import '../../domain/entities/therapist.dart';

/// Full therapist card used in the discovery list.
class TherapistCard extends StatelessWidget {
  const TherapistCard({
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
    return MnCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: PhotoPlaceholder(t.name),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            t.name,
                            style: MnText.headline.copyWith(color: c.ink),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (t.verified) ...[
                          const SizedBox(width: 6),
                          const Verified(size: 15),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.title,
                      style: MnText.callout.copyWith(color: c.ink2),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Stars(t.rating, size: 12),
                        const SizedBox(width: 8),
                        Text(
                          '(${t.reviews})',
                          style: MnText.foot.copyWith(color: c.ink3),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: c.ink4,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${t.years} yrs',
                          style: MnText.foot.copyWith(color: c.ink3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: c.fill,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: MnIcon('bookmark', size: 17, color: c.ink3, stroke: 1.8),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in t.tags.take(3))
                Chip2(tag, outline: true, height: 28),
            ],
          ),
          const Hairline(margin: EdgeInsets.fromLTRB(0, 14, 0, 12)),
          Row(
            children: [
              MnIcon('clock', size: 16, color: c.green),
              const SizedBox(width: 8),
              Text(
                'Next: ${t.next}',
                style: MnText.foot.copyWith(
                  color: c.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '£${t.price}',
                style: MnText.headline.copyWith(color: c.ink),
              ),
              const SizedBox(width: 4),
              Text('/session', style: MnText.foot.copyWith(color: c.ink3)),
              const SizedBox(width: 10),
              MnButton(
                label: 'View',
                small: true,
                expand: false,
                onPressed: onTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
