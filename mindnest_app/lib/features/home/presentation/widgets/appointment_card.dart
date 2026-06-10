import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/features/discovery/domain/entities/appointment.dart';
import 'package:mindnest_app/features/discovery/domain/entities/therapist.dart';

/// Upcoming-session card shown on Home. Renders the booked appointment using
/// the therapist resolved from the discovery feature.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.therapist,
    required this.onTap,
  });
  final Appointment appointment;
  final Therapist therapist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final a = appointment;
    final t = therapist;
    return MnCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Avatar(t.name, size: 52, photo: true),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MnText.headline.copyWith(color: c.ink),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${a.type} · ${a.mins} min',
                        style: MnText.foot.copyWith(color: c.ink3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Badge2('Accepted', kind: BadgeKind.accept),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: c.primaryTint,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                MnIcon('calendar', size: 16, color: c.primary, stroke: 1.9),
                const SizedBox(width: 8),
                Text(
                  a.date,
                  style: MnText.foot.copyWith(
                    color: c.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: c.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  a.time,
                  style: MnText.foot.copyWith(
                    color: c.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                MnIcon('video', size: 18, color: c.primary, stroke: 1.9),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
