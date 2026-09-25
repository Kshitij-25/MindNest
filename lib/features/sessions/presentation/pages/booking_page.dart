import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../therapists/presentation/widgets/therapist_widgets.dart';
import '../../domain/entities/appointment.dart';
import '../bloc/booking_cubit.dart';
import '../widgets/appointment_card.dart';

@RoutePage()
class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.therapistId, this.rescheduleOf});

  final String therapistId;
  final String? rescheduleOf;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BookingCubit>()..load(therapistId, rescheduleOf: rescheduleOf),
      child: BlocConsumer<BookingCubit, BookingState>(
        listenWhen: (a, b) => a.booked == null && b.booked != null || a.error != b.error,
        listener: (context, s) {
          if (s.booked != null) {
            Adaptive.success(context);
            context.router.replace(BookingSuccessRoute(appointment: s.booked!));
          } else if (s.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.error!)));
          }
        },
        builder: (context, s) {
          final t = s.therapist;
          return MnPage(
            header: MnNavHeader(title: rescheduleOf == null ? 'Book appointment' : 'Reschedule'),
            maxWidth: 720,
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            body: t == null ? const LoadingView() : _Body(s: s),
            bottom: t == null
                ? null
                : MnButton(
                    label: s.slot == null
                        ? 'Select a time'
                        : 'Confirm · ${DateFormat.E().format(s.slot!)} ${formatTime(s.slot!)}',
                    onPressed: s.slot == null ? null : () => _confirm(context, s),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _confirm(BuildContext context, BookingState s) {
    final cubit = context.read<BookingCubit>();
    return showMnSheet<void>(
      context,
      builder: (ctx) => BlocProvider.value(value: cubit, child: const _ConfirmSheet()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.s});
  final BookingState s;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<BookingCubit>();
    final t = s.therapist!;
    final day = s.day;
    final types = SessionType.values.where((x) => t.sessionTypes.contains(x.label)).toList();
    final month = day == null ? '' : DateFormat.MMMM().format(day.date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TherapistSummaryRow(therapist: t),
        const SizedBox(height: 24),
        Text('Select a date · $month', style: context.text.headline),
        const SizedBox(height: 14),
        SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: s.days.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) => _DayPill(
              day: s.days[i],
              selected: i == s.dayIndex,
              onTap: () => cubit.selectDay(i),
            ),
          ),
        ),
        const SizedBox(height: 26),
        Text('Available slots', style: context.text.headline),
        const SizedBox(height: 14),
        if (day == null || !day.available)
          MnCard(
            style: MnCardStyle.inset,
            child: Text('No availability this day. Try another date.', style: context.text.callout.copyWith(color: c.ink2)),
          )
        else
          LayoutBuilder(builder: (context, box) {
            final cols = box.maxWidth > 520 ? 4 : 3;
            final w = (box.maxWidth - (cols - 1) * 10) / cols;
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final slot in day.slots)
                  SizedBox(
                    width: w,
                    child: _SlotButton(
                      slot: slot,
                      selected: s.slot == slot.time,
                      onTap: () => cubit.selectSlot(slot.time),
                    ),
                  ),
              ],
            );
          }),
        const SizedBox(height: 26),
        Text('Session type', style: context.text.headline),
        const SizedBox(height: 14),
        MnSegmented<SessionType>(options: types, value: s.type, labelOf: (x) => x.label, onChanged: cubit.setType),
        const SizedBox(height: 26),
        Text('Repeat', style: context.text.headline),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in Recurrence.values)
              MnChip(label: r.label, selected: s.recurrence == r, onTap: () => cubit.setRecurrence(r)),
          ],
        ),
        const SizedBox(height: 26),
        Text('Reminders', style: context.text.headline),
        const SizedBox(height: 12),
        MnCard(
          style: MnCardStyle.inset,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            children: [
              for (final (i, r) in Reminder.values.indexed) ...[
                if (i > 0) const Hairline(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      MnIcon(MnIcons.bell, size: 18, color: c.primary),
                      const SizedBox(width: 12),
                      Expanded(child: Text(r.label, style: context.text.body)),
                      MnToggle(
                        value: s.reminders.contains(r),
                        onChanged: (_) => cubit.toggleReminder(r),
                        semanticLabel: 'Reminder ${r.label}',
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DayPill extends StatelessWidget {
  const _DayPill({required this.day, required this.selected, required this.onTap});
  final BookingDay day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final disabled = !day.available;
    return Semantics(
      selected: selected,
      enabled: !disabled,
      label: DateFormat.MMMMEEEEd().format(day.date),
      excludeSemantics: true,
      child: Pressable(
        onTap: disabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 56,
          decoration: BoxDecoration(
            color: selected ? c.primary : (disabled ? Colors.transparent : c.surface),
            borderRadius: BorderRadius.circular(16),
            boxShadow: selected
                ? [BoxShadow(color: c.primaryRing, blurRadius: 16, offset: const Offset(0, 6))]
                : (disabled ? const [] : MnShadows.sm(c)),
          ),
          child: Opacity(
            opacity: disabled ? .35 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat.E().format(day.date),
                    style: context.text.cap.copyWith(color: selected ? c.onPrimary.withValues(alpha: .8) : c.ink3)),
                const SizedBox(height: 4),
                Text('${day.date.day}', style: context.text.title3.copyWith(color: selected ? c.onPrimary : c.ink)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SlotButton extends StatelessWidget {
  const _SlotButton({required this.slot, required this.selected, required this.onTap});
  final TimeSlot slot;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final taken = slot.taken;
    return Semantics(
      selected: selected,
      enabled: !taken,
      child: Pressable(
        onTap: taken ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? c.primaryTint : (taken ? c.fill : c.surface),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? c.primary : c.hairline, width: 1.5),
          ),
          child: Text(
            formatTime(slot.time),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: selected ? c.primary : (taken ? c.ink4 : c.ink),
              decoration: taken ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmSheet extends StatelessWidget {
  const _ConfirmSheet();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocConsumer<BookingCubit, BookingState>(
      listenWhen: (a, b) => a.booked == null && b.booked != null,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, s) {
        final t = s.therapist!;
        final rows = [
          ('Therapist', t.name),
          ('Date', DateFormat('EEE, d MMMM').format(s.slot!)),
          ('Time', formatTime(s.slot!)),
          ('Type', '${s.type.label} session · 50 min'),
          if (s.recurrence != Recurrence.oneTime) ('Repeats', s.recurrence.label),
          ('Total', '£${t.price}${s.recurrence != Recurrence.oneTime ? ' / session' : ''}'),
        ];
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 4, 22, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Confirm booking', style: context.text.title3),
              const SizedBox(height: 18),
              MnCard(
                style: MnCardStyle.inset,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  children: [
                    for (final (i, r) in rows.indexed) ...[
                      if (i > 0) const Hairline(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        child: Row(
                          children: [
                            Text(r.$1, style: context.text.callout.copyWith(color: c.ink2)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                r.$2,
                                textAlign: TextAlign.right,
                                style: context.text.headline.copyWith(color: r.$1 == 'Total' ? c.primary : c.ink),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                child: Row(
                  children: [
                    MnIcon(MnIcons.info, size: 16, color: c.ink3),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your request is sent to ${t.firstName} to accept.',
                        style: context.text.foot.copyWith(color: c.ink3),
                      ),
                    ),
                  ],
                ),
              ),
              MnButton(
                label: 'Send booking request',
                loading: s.submitting,
                onPressed: () => context.read<BookingCubit>().confirm(),
              ),
            ],
          ),
        );
      },
    );
  }
}
