import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../shell/presentation/shell_tabs.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/calendar_cubit.dart';
import '../bloc/requests_bloc.dart';
import '../widgets/practice_widgets.dart';
import '../widgets/request_card.dart';

const _startHour = 9;
const _hours = 9; // 9am–5pm
const _hourHeight = 64.0;

@RoutePage()
class ProCalendarPage extends StatelessWidget {
  const ProCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CalendarCubit>()..load()),
        BlocProvider.value(value: getIt<RequestsBloc>()..add(const RequestsEvent.load())),
      ],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: ResponsiveLayout(
            phone: (_) => const _AgendaView(),
            tablet: (context) => Row(
              children: [
                const Expanded(child: _WeekView()),
                Container(width: .5, color: context.colors.hairline),
                SizedBox(width: context.isWide ? 340 : 300, child: const _RequestsRail()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.s});
  final CalendarState s;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          if (isPushedPage(context)) ...[
            MnIconButton(icon: MnIcons.back, tooltip: 'Back', onPressed: () => context.router.maybePop()),
            const SizedBox(width: 4),
          ],
          Expanded(child: Text(DateFormat.yMMMM().format(s.weekStart), style: context.text.title2)),
          MnIconButton(icon: MnIcons.chevL, tooltip: 'Previous week', square: true, iconSize: 20, onPressed: () => cubit.shiftWeek(-1)),
          const SizedBox(width: 4),
          MnIconButton(icon: MnIcons.chevR, tooltip: 'Next week', square: true, iconSize: 20, onPressed: () => cubit.shiftWeek(1)),
        ],
      ),
    );
  }
}

/// Phone: week strip + day agenda + pending requests.
class _AgendaView extends StatelessWidget {
  const _AgendaView();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, s) {
        final cubit = context.read<CalendarCubit>();
        final day = s.sessionsOn(s.selectedDay);
        final pending = context.watch<RequestsBloc>().state.requests.where((r) => r.status == RequestStatus.pending).toList();
        return ListView(
          padding: EdgeInsets.only(bottom: 24 + MediaQuery.paddingOf(context).bottom),
          children: [
            _Header(s: s),
            SizedBox(
              height: 76,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final d = s.weekStart.add(Duration(days: i));
                  final sel = d.day == s.selectedDay.day && d.month == s.selectedDay.month;
                  final has = s.sessionsOn(d).isNotEmpty;
                  return Pressable(
                    onTap: () => cubit.selectDay(d),
                    semanticLabel: DateFormat.MMMMEEEEd().format(d),
                    child: AnimatedContainer(
                      duration: MnMotion.base,
                      width: 52,
                      decoration: BoxDecoration(
                        color: sel ? c.primary : c.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: sel ? [BoxShadow(color: c.primaryRing, blurRadius: 16, offset: const Offset(0, 6))] : MnShadows.sm(c),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat.E().format(d), style: context.text.cap.copyWith(color: sel ? c.onPrimary.withValues(alpha: .8) : c.ink3)),
                          Text('${d.day}', style: context.text.title3.copyWith(color: sel ? c.onPrimary : c.ink)),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: has ? (sel ? c.onPrimary : c.primary) : Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionHeader(title: DateFormat('EEEE d MMMM').format(s.selectedDay)),
                  if (s.loading)
                    const LoadingView()
                  else if (day.isEmpty)
                    MnCard(style: MnCardStyle.inset, child: Text('No sessions this day.', style: context.text.callout.copyWith(color: c.ink2)))
                  else
                    for (final e in day)
                      Padding(padding: const EdgeInsets.only(bottom: 10), child: ScheduleRow(session: e, trailing: e.recurring ? MnIcon(MnIcons.clock, size: 16, color: c.ink3) : null)),
                  if (pending.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    SectionHeader(title: 'Booking requests', subtitle: '${pending.length} awaiting response'),
                    for (final r in pending)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RequestCard(
                          request: r,
                          compact: true,
                          onOpen: () => context.router.push(ProRequestDetailRoute(requestId: r.id)),
                          onRespond: (st) => context.read<RequestsBloc>().add(RequestsEvent.responded(r.id, st)),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Tablet: Mon–Fri time grid with event blocks.
class _WeekView extends StatelessWidget {
  const _WeekView();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, s) {
        final days = [for (var i = 0; i < 5; i++) s.weekStart.add(Duration(days: i))];
        final now = DateTime.now();
        return Column(
          children: [
            _Header(s: s),
            const Hairline(),
            Row(
              children: [
                const SizedBox(width: 52),
                for (final d in days)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(border: Border(left: BorderSide(color: c.hairline, width: .5))),
                      child: Column(
                        children: [
                          Text(DateFormat.E().format(d), style: context.text.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(
                            '${d.day}',
                            style: context.text.title3.copyWith(
                              color: d.day == now.day && d.month == now.month ? c.primary : c.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const Hairline(),
            Expanded(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, box) {
                    final colW = (box.maxWidth - 52) / 5;
                    return SizedBox(
                      height: _hours * _hourHeight,
                      child: Stack(
                        children: [
                          for (var h = 0; h < _hours; h++) ...[
                            Positioned(
                              top: h * _hourHeight + 4,
                              left: 0,
                              width: 44,
                              child: Text(
                                DateFormat('ha').format(DateTime(2000, 1, 1, _startHour + h)).toLowerCase(),
                                textAlign: TextAlign.right,
                                style: context.text.cap.copyWith(color: c.ink3),
                              ),
                            ),
                            Positioned(
                              top: (h + 1) * _hourHeight,
                              left: 52,
                              right: 0,
                              child: Container(height: .5, color: c.hairline),
                            ),
                          ],
                          for (var i = 0; i <= 5; i++)
                            Positioned(top: 0, bottom: 0, left: 52 + i * colW, child: Container(width: .5, color: c.hairline)),
                          for (final e in s.sessions)
                            if (e.startsAt.weekday <= 5 && e.startsAt.hour >= _startHour)
                              Positioned(
                                top: (e.startsAt.hour - _startHour + e.startsAt.minute / 60) * _hourHeight + 3,
                                left: 52 + (e.startsAt.weekday - 1) * colW + 3,
                                width: colW - 6,
                                height: _hourHeight * (e.minutes / 60).clamp(.75, 2) - 6,
                                child: _EventBlock(e: e),
                              ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EventBlock extends StatelessWidget {
  const _EventBlock({required this.e});
  final ScheduledSession e;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = sessionTypeColor(c, e.type);
    return Semantics(
      label: '${e.clientName}, ${e.type}, ${DateFormat('EEEE h:mm a').format(e.startsAt)}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 6, 4),
        decoration: BoxDecoration(
          color: Color.alphaBlend(col.withValues(alpha: .15), c.surface),
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: col, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.clientName, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.text.cap.copyWith(color: col, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Row(
              children: [
                MnIcon(e.type == 'Chat' ? MnIcons.message : MnIcons.video, size: 11, color: c.ink3),
                if (e.recurring) ...[const SizedBox(width: 4), MnIcon(MnIcons.clock, size: 11, color: c.ink3)],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestsRail extends StatelessWidget {
  const _RequestsRail();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<RequestsBloc, RequestsState>(
      builder: (context, s) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking requests', style: context.text.title3),
                  const SizedBox(height: 2),
                  Text('${s.pendingCount} awaiting response', style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
            const Hairline(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  for (final r in s.requests)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: RequestCard(
                        request: r,
                        compact: true,
                        onOpen: () => context.router.push(ProRequestDetailRoute(requestId: r.id)),
                        onRespond: (st) {
                          context.read<RequestsBloc>().add(RequestsEvent.responded(r.id, st));
                          if (st == RequestStatus.accepted) context.read<CalendarCubit>().load();
                        },
                      ),
                    ),
                  MnCard(
                    style: MnCardStyle.inset,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MnIcon(MnIcons.clock, size: 18, color: c.clay),
                            const SizedBox(width: 10),
                            Text('Recurring sessions', style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '3 weekly slots are auto-held for returning clients. Manage in availability settings.',
                          style: context.text.cap.copyWith(color: c.ink2, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
