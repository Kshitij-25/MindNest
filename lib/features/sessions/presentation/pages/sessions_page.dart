import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/appointment.dart';
import '../bloc/sessions_bloc.dart';
import '../widgets/appointment_card.dart';
import '../widgets/cancel_sheet.dart';

@RoutePage()
class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SessionsBloc>()..add(const SessionsEvent.load()),
      child: const _SessionsView(),
    );
  }
}

class _SessionsView extends StatelessWidget {
  const _SessionsView();

  Future<void> _cancel(BuildContext context, Appointment a) async {
    final choice = await showCancelSheet(context, a);
    if (!context.mounted || choice == null) return;
    if (choice == CancelChoice.cancel) {
      context.read<SessionsBloc>().add(SessionsEvent.cancelled(a.id));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Session cancelled')));
    } else {
      context.router.push(BookingRoute(therapistId: a.therapist.id, rescheduleOf: a.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<SessionsBloc, SessionsState>(
      builder: (context, s) {
        return MnPage(
          maxWidth: 900,
          padding: EdgeInsets.fromLTRB(context.gutter, 16, context.gutter, 40),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LargeTitle(
                  title: 'Your sessions',
                  trailing: MnButton(
                    label: context.isTablet ? 'Book a session' : 'Book',
                    icon: MnIcons.plus,
                    size: MnButtonSize.small,
                    expand: false,
                    onPressed: () => context.router.push(const DiscoverRoute()),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage upcoming appointments, reminders and recurring bookings.',
                  style: context.text.sub.copyWith(color: c.ink3),
                ),
                const SizedBox(height: 24),
                const SectionHeader(title: 'Upcoming'),
                if (s.status.isLoading && s.upcoming.isEmpty)
                  const LoadingView()
                else if (s.upcoming.isEmpty)
                  MnCard(
                    child: EmptyState(
                      icon: MnIcons.calendar,
                      title: 'No sessions booked yet',
                      message:
                          'When you’re ready, booking a session takes less than a minute. Your therapist will confirm shortly after.',
                      actionLabel: 'Find a therapist',
                      onAction: () => context.router.push(const DiscoverRoute()),
                    ),
                  )
                else
                  Stagger(
                    spacing: 14,
                    children: [
                      for (final a in s.upcoming) _UpcomingCard(appointment: a, onCancel: () => _cancel(context, a)),
                    ],
                  ),
                if (s.past.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  const SectionHeader(title: 'Past sessions'),
                  MnCard(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        for (final (i, p) in s.past.indexed) ...[
                          if (i > 0) const Hairline(indent: 70),
                          _PastRow(appointment: p),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
        );
      },
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.appointment, required this.onCancel});
  final Appointment appointment;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = appointment;
    final info = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(child: Text(a.therapist.name, style: context.text.headline, overflow: TextOverflow.ellipsis)),
              if (a.therapist.verified) ...[const SizedBox(width: 6), const VerifiedBadge(size: 14)],
            ],
          ),
          const SizedBox(height: 2),
          Text('${formatTime(a.startsAt)} · ${a.type.label} · ${a.minutes} min',
              style: context.text.sub.copyWith(color: c.ink2)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              if (a.status == AppointmentStatus.pending) MnBadge.status(a.status.label),
              if (a.recurrence != Recurrence.oneTime)
                MnBadge(label: a.recurrence.label, tone: MnBadgeTone.clay, icon: MnIcons.clock),
              if (a.reminders.isNotEmpty) const MnBadge(label: 'Reminders on', tone: MnBadgeTone.neutral, icon: MnIcons.bell),
            ],
          ),
        ],
      ),
    );

    final actions = [
      MnButton(
        label: 'Join',
        icon: sessionIcon(a.type),
        size: MnButtonSize.small,
        onPressed: () => context.router.push(ChatRoute(therapistId: a.therapist.id)),
      ),
      MnButton.secondary(
        label: 'Reschedule',
        size: MnButtonSize.small,
        onPressed: () => context.router.push(BookingRoute(therapistId: a.therapist.id, rescheduleOf: a.id)),
      ),
      MnButton(label: 'Cancel', variant: MnButtonVariant.ghost, size: MnButtonSize.small, onPressed: onCancel),
    ];

    return MnCard(
      padding: const EdgeInsets.all(18),
      child: context.isTablet
          ? Row(
              children: [
                DateBlock(date: a.startsAt),
                const SizedBox(width: 16),
                MnAvatar(name: a.therapist.name, size: 52, photo: true),
                const SizedBox(width: 14),
                info,
                const SizedBox(width: 12),
                SizedBox(
                  width: 140,
                  child: Column(children: [actions[0], const SizedBox(height: 8), actions[1], actions[2]]),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [DateBlock(date: a.startsAt, width: 56), const SizedBox(width: 14), info],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: actions[0]),
                    const SizedBox(width: 8),
                    Expanded(child: actions[1]),
                  ],
                ),
                actions[2],
              ],
            ),
    );
  }
}

class _PastRow extends StatelessWidget {
  const _PastRow({required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = appointment;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          MnAvatar(name: a.therapist.name, size: 40, photo: true),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.therapist.name, style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
                Text(
                  '${DateFormat('d MMM').format(a.startsAt)} · ${formatTime(a.startsAt)} · ${a.minutes} min',
                  style: context.text.cap.copyWith(color: c.ink3),
                ),
              ],
            ),
          ),
          if (context.isTablet) ...[const MnBadge(label: 'Completed', tone: MnBadgeTone.accept), const SizedBox(width: 12)],
          MnButton.secondary(
            label: 'Book again',
            size: MnButtonSize.small,
            expand: false,
            onPressed: () => context.router.push(BookingRoute(therapistId: a.therapist.id)),
          ),
        ],
      ),
    );
  }
}
