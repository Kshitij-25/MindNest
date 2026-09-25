import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../../../therapists/presentation/widgets/therapist_widgets.dart';
import '../../domain/entities/appointment.dart';
import '../widgets/appointment_card.dart';

@RoutePage()
class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = appointment;
    final t = a.therapist;
    final rows = [
      (MnIcons.calendar, DateFormat('EEE, d MMMM').format(a.startsAt)),
      (MnIcons.clock, '${formatTime(a.startsAt)} · ${a.minutes} min'),
      (sessionIcon(a.type), '${a.type.label} session'),
      if (a.recurrence != Recurrence.oneTime) (MnIcons.pulse, 'Repeats ${a.recurrence.label.toLowerCase()}'),
      if (a.reminders.isNotEmpty) (MnIcons.bell, '${a.reminders.length} reminder${a.reminders.length > 1 ? 's' : ''} set'),
    ];
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -.76),
            radius: 1.1,
            colors: [c.primaryTint, c.bg],
            stops: const [0, .48],
          ),
        ),
        child: MnPage(
          background: Colors.transparent,
          maxWidth: 480,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          body: Column(
            children: [
              SuccessCheck(color: c.primary, ring: c.primaryRing),
              const SizedBox(height: 26),
              FadeUp(child: Text('Request sent', style: context.text.title1)),
              const SizedBox(height: 8),
              FadeUp(
                child: Text(
                  'We’ve let ${t.firstName} know. You’ll be notified the moment it’s confirmed.',
                  textAlign: TextAlign.center,
                  style: context.text.body.copyWith(color: c.ink2),
                ),
              ),
              const SizedBox(height: 16),
              const FadeUp(child: MnBadge(label: 'Pending confirmation', tone: MnBadgeTone.pending, icon: MnIcons.clock)),
              const SizedBox(height: 26),
              FadeUp(
                child: MnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 46, height: 46, child: PortraitPlaceholder(name: t.name, radius: 13)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.name, style: context.text.headline),
                              Text(t.specialty, style: context.text.foot.copyWith(color: c.ink2)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final r in rows)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            children: [
                              MnIcon(r.$1, size: 18, color: c.primary, stroke: 1.9),
                              const SizedBox(width: 12),
                              Text(r.$2, style: context.text.callout.copyWith(color: c.ink2)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MnButton(
                label: 'Message ${t.firstName}',
                onPressed: () => context.router.replace(ChatRoute(therapistId: t.id)),
              ),
              const SizedBox(height: 10),
              MnButton.ghost(label: 'Back to home', onPressed: () => context.router.popUntilRoot()),
            ],
          ),
        ),
      ),
    );
  }
}
