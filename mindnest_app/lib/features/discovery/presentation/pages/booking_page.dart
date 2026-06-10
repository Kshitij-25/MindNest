import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/therapist.dart';
import '../cubit/booking_cubit.dart';
import 'booking_success_page.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.therapist});
  final Therapist therapist;

  static const days = [
    ('Mon', '2'),
    ('Tue', '3'),
    ('Wed', '4'),
    ('Thu', '5'),
    ('Fri', '6'),
    ('Sat', '7'),
    ('Sun', '8'),
  ];
  static const slots = [
    '9:00',
    '10:00',
    '11:30',
    '1:00',
    '2:30',
    '4:00',
    '5:30',
  ];
  static const off = [1, 3];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BookingCubit>(),
      child: Builder(
        builder: (context) {
          final c = context.c;
          final t = therapist;
          return BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              final cubit = context.read<BookingCubit>();
              return MnScaffold(
                child: Column(
                  children: [
                    SizedBox(height: safeTop(context)),
                    NavHeader(
                      title: 'Book appointment',
                      onBack: () => context.pop(),
                    ),
                    Expanded(
                      child: NoGlow(
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                          children: [
                            MnCard(
                              kind: MnCardKind.flat,
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: SizedBox(
                                      width: 48,
                                      height: 48,
                                      child: PhotoPlaceholder(t.name),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.name,
                                          style: MnText.headline.copyWith(
                                            color: c.ink,
                                          ),
                                        ),
                                        Text(
                                          t.spec,
                                          style: MnText.foot.copyWith(
                                            color: c.ink2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stars(t.rating, size: 13),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Select a date · June',
                              style: MnText.headline.copyWith(color: c.ink),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              height: 72,
                              child: NoGlow(
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: days.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (_, i) {
                                    final on = state.dateIndex == i;
                                    final disabled = off.contains(i);
                                    return GestureDetector(
                                      onTap: disabled
                                          ? null
                                          : () => cubit.selectDate(i),
                                      child: Opacity(
                                        opacity: disabled ? 0.35 : 1,
                                        child: Container(
                                          width: 56,
                                          decoration: BoxDecoration(
                                            color: on
                                                ? c.primary
                                                : (disabled
                                                      ? Colors.transparent
                                                      : c.surface),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: on
                                                ? c.primaryGlow()
                                                : (disabled ? null : c.shSm),
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                days[i].$1,
                                                style: MnText.cap.copyWith(
                                                  color: on
                                                      ? Colors.white70
                                                      : c.ink3,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                days[i].$2,
                                                style: MnText.title3.copyWith(
                                                  color: on
                                                      ? Colors.white
                                                      : c.ink,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 26),
                            Text(
                              'Available slots',
                              style: MnText.headline.copyWith(color: c.ink),
                            ),
                            const SizedBox(height: 14),
                            GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.6,
                              children: [
                                for (var i = 0; i < slots.length; i++)
                                  _slotChip(context, c, state, cubit, i),
                              ],
                            ),
                            const SizedBox(height: 26),
                            Text(
                              'Session type',
                              style: MnText.headline.copyWith(color: c.ink),
                            ),
                            const SizedBox(height: 14),
                            Segmented(
                              options: const ['Video', 'Voice', 'Chat'],
                              value: state.type,
                              onChanged: cubit.selectType,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        22,
                        12,
                        22,
                        safeBottom(context) + 16,
                      ),
                      decoration: BoxDecoration(
                        color: c.bg,
                        border: Border(
                          top: BorderSide(color: c.hairline, width: 0.5),
                        ),
                      ),
                      child: MnButton(
                        label: state.slot != null
                            ? 'Confirm · ${days[state.dateIndex].$1} ${state.slot}'
                            : 'Select a time',
                        onPressed: state.slot != null
                            ? () => _confirm(context, t, state, cubit)
                            : null,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _slotChip(
    BuildContext context,
    MnColors c,
    BookingState state,
    BookingCubit cubit,
    int i,
  ) {
    final s = slots[i];
    final on = state.slot == s;
    final taken = i == 2 || i == 5;
    return GestureDetector(
      onTap: taken ? null : () => cubit.selectSlot(s),
      child: Container(
        decoration: BoxDecoration(
          color: on ? c.primaryTint : (taken ? c.fill : c.surface),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: on ? c.primary : c.hairline, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          '$s ${i < 3 ? 'AM' : 'PM'}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: on ? c.primary : (taken ? c.ink4 : c.ink),
            decoration: taken ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }

  void _confirm(
    BuildContext context,
    Therapist t,
    BookingState state,
    BookingCubit cubit,
  ) {
    showMnSheet(context, (sheetCtx) {
      final c = sheetCtx.c;
      final rows = [
        ('Therapist', t.name),
        (
          'Date',
          '${days[state.dateIndex].$1}, ${days[state.dateIndex].$2} June',
        ),
        ('Time', '${state.slot} PM'),
        ('Type', '${state.type} session · 50 min'),
        ('Total', '£${t.price}'),
      ];
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: SheetGrab()),
            Text(
              'Confirm booking',
              style: MnText.title3.copyWith(color: c.ink),
            ),
            const SizedBox(height: 18),
            MnCard(
              kind: MnCardKind.inset,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (var i = 0; i < rows.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: i < rows.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: c.hairline,
                                  width: 0.5,
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              rows[i].$1,
                              style: MnText.callout.copyWith(color: c.ink2),
                            ),
                          ),
                          Text(
                            rows[i].$2,
                            style: MnText.headline.copyWith(
                              color: rows[i].$1 == 'Total' ? c.primary : c.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: Row(
                children: [
                  MnIcon('info', size: 16, color: c.ink3),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your request is sent to ${t.firstName} to accept.',
                      style: MnText.foot.copyWith(color: c.ink3),
                    ),
                  ),
                ],
              ),
            ),
            MnButton(
              label: 'Send booking request',
              onPressed: () async {
                final draft = BookingDraft(
                  therapistId: t.id,
                  dayLabel: days[state.dateIndex].$1,
                  dateLabel: days[state.dateIndex].$2,
                  slot: state.slot!,
                  type: state.type,
                );
                final ok = await cubit.submit(draft);
                if (!sheetCtx.mounted) return;
                Navigator.pop(sheetCtx);
                if (ok && context.mounted) {
                  context.goNamed(RouteNames.userShell);
                  context.pushNamed(
                    RouteNames.bookingSuccess,
                    extra: BookingSuccessArgs(
                      therapist: t,
                      dayLabel: days[state.dateIndex].$1,
                      dateLabel: days[state.dateIndex].$2,
                      slot: state.slot!,
                      type: state.type,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
