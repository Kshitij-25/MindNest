import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/appointment.dart';

String formatDay(DateTime d) => DateFormat('EEE, d MMM').format(d);
String formatTime(DateTime d) => DateFormat.jm().format(d);

MnIconData sessionIcon(SessionType t) => switch (t) {
      SessionType.video => MnIcons.video,
      SessionType.voice => MnIcons.phone,
      SessionType.chat => MnIcons.message,
    };

/// Upcoming-session card with tinted date footer (`AppointmentCard`).
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment, this.onTap});
  final Appointment appointment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = appointment;
    return MnCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      clip: true,
      semanticLabel: 'Session with ${a.therapist.name}, ${formatDay(a.startsAt)} at ${formatTime(a.startsAt)}',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                MnAvatar(name: a.therapist.name, size: 52, photo: true),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.therapist.name, style: context.text.headline, maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text('${a.type.label} session · ${a.minutes} min', style: context.text.callout.copyWith(color: c.ink2)),
                    ],
                  ),
                ),
                MnBadge.status(a.status.label),
              ],
            ),
          ),
          Container(
            color: c.primaryTint,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                MnIcon(MnIcons.calendar, size: 18, color: c.primary),
                const SizedBox(width: 8),
                Text(formatDay(a.startsAt), style: context.text.headline.copyWith(color: c.primary)),
                Container(
                  width: 3,
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(color: c.primary.withValues(alpha: .5), shape: BoxShape.circle),
                ),
                Text(formatTime(a.startsAt), style: context.text.headline.copyWith(color: c.primary)),
                const Spacer(),
                MnIcon(sessionIcon(a.type), size: 18, color: c.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Date block (weekday + day number) used on session rows.
class DateBlock extends StatelessWidget {
  const DateBlock({super.key, required this.date, this.width = 64});
  final DateTime date;
  final double width;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: c.primaryTint, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(DateFormat.E().format(date).toUpperCase(),
              style: context.text.cap.copyWith(color: c.primary, fontWeight: FontWeight.w800)),
          Text('${date.day}', style: context.text.title2.copyWith(color: c.primary, height: 1)),
        ],
      ),
    );
  }
}
