import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../shell/presentation/shell_tabs.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/requests_bloc.dart';
import '../widgets/practice_widgets.dart';

String _greeting() {
  final h = DateTime.now().hour;
  return h < 12 ? 'Good morning' : (h < 18 ? 'Good afternoon' : 'Good evening');
}

@RoutePage()
class ProDashboardPage extends StatelessWidget {
  const ProDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<DashboardCubit>()..load()),
        BlocProvider.value(value: getIt<RequestsBloc>()),
      ],
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, s) {
          final d = s.data;
          if (d == null) return const Scaffold(body: LoadingView());
          return ResponsiveLayout(phone: (_) => _Phone(d: d), tablet: (_) => _Tablet(d: d));
        },
      ),
    );
  }
}

String _drName(BuildContext context) {
  final n = context.select((AuthBloc b) => b.state.user?.name ?? '');
  return n.startsWith('Dr.') ? 'Dr. ${n.split(' ').last}' : n.split(' ').first;
}

void _openChat(BuildContext context, ScheduledSession s) => context.router.push(ChatRoute(therapistId: s.clientId));

class _Phone extends StatelessWidget {
  const _Phone({required this.d});
  final PracticeDashboard d;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final user = context.select((AuthBloc b) => b.state.user);
    final pending = context.select((RequestsBloc b) => b.state.pendingCount);
    final stats = [
      ('${d.sessionsToday}', 'Sessions today', MnIcons.calendar, c.primary),
      ('$pending', 'New requests', MnIcons.bell, c.clay),
      (d.rating.toStringAsFixed(1), 'Avg. rating', MnIcons.star, MnColors.moss500),
      (money(d.weekEarnings), 'This week', MnIcons.trend, c.green),
    ];
    final today = d.schedule.where((x) => x.startsAt.day == DateTime.now().day).toList();
    return MnPage(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeUp(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('EEEE, d MMMM').format(DateTime.now()),
                          style: context.text.foot.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text('${_greeting()}, ${_drName(context)}', style: context.text.serif(size: 28)),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MnAvatar(name: user?.name ?? '', size: 46, photo: true),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle),
                        child: const VerifiedBadge(size: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          FadeUp(
            delay: const Duration(milliseconds: 60),
            child: ResponsiveGrid(
              columns: 2,
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final st in stats)
                  MnCard(
                    style: MnCardStyle.flat,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconTile(size: 38, radius: 11, color: st.$4.withValues(alpha: .14), child: MnIcon(st.$3, size: 19, color: st.$4)),
                        const SizedBox(height: 12),
                        Text(st.$1, style: context.text.title2),
                        const SizedBox(height: 2),
                        Text(st.$2, style: context.text.foot.copyWith(color: c.ink3)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          FadeUp(
            delay: const Duration(milliseconds: 120),
            child: RequestsBanner(count: pending, onTap: () => goToTab(context, ProTab.requests)),
          ),
          const SizedBox(height: 22),
          SectionHeader(
            title: 'Today’s sessions',
            action: 'Calendar',
            onAction: () => openSection(context, const ProCalendarRoute(), ProTab.calendar),
          ),
          if (today.isEmpty)
            MnCard(style: MnCardStyle.inset, child: Text('Nothing scheduled today.', style: context.text.callout.copyWith(color: c.ink2)))
          else
            Stagger(
              spacing: 12,
              children: [
                for (final s in today)
                  ScheduleRow(
                    session: s,
                    trailing: MnIconButton(
                      icon: s.type == 'Chat' ? MnIcons.message : MnIcons.video,
                      tooltip: 'Open ${s.type.toLowerCase()} with ${s.clientName}',
                      iconSize: 19,
                      stroke: 1.9,
                      color: c.primary,
                      onPressed: () => _openChat(context, s),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: MnButton.secondary(
                  label: 'Earnings',
                  icon: MnIcons.trend,
                  size: MnButtonSize.small,
                  onPressed: () => openSection(context, const ProEarningsRoute(), ProTab.earnings),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MnButton.secondary(
                  label: 'Client notes',
                  icon: MnIcons.users,
                  size: MnButtonSize.small,
                  onPressed: () => openSection(context, const ProClientsRoute(), ProTab.clients),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tablet extends StatefulWidget {
  const _Tablet({required this.d});
  final PracticeDashboard d;

  @override
  State<_Tablet> createState() => _TabletState();
}

class _TabletState extends State<_Tablet> {
  String _period = 'Week';

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final d = widget.d;
    final pending = context.select((RequestsBloc b) => b.state.pendingCount);
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final todayIdx = DateTime.now().weekday - 1;

    final main = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Earnings overview', style: context.text.title3),
                        const SizedBox(height: 6),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          spacing: 8,
                          children: [
                            Text(money(d.weekEarnings), style: context.text.title1),
                            Text('↑ 18% vs last week', style: TextStyle(color: c.green, fontWeight: FontWeight.w700, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: MnSegmented<String>(
                      options: const ['Week', 'Month', 'Year'],
                      value: _period,
                      labelOf: (s) => s,
                      onChanged: (v) => setState(() => _period = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              MnBarChart(
                height: 170,
                valueLabel: money,
                data: [
                  for (final (i, v) in d.earningsWeek.indexed) ChartBar(days[i], v.toDouble(), highlight: i == todayIdx),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Today’s schedule', style: context.text.title3)),
                  MnLinkButton(label: 'Open calendar', fontSize: 14, onPressed: () => goToTab(context, ProTab.calendar)),
                ],
              ),
              const SizedBox(height: 12),
              for (final s in d.schedule)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ScheduleRow(
                    session: s,
                    onTap: () => goToTab(context, ProTab.clients),
                    trailing: MnChip(
                      label: s.type,
                      outline: true,
                      icon: s.type == 'Chat' ? MnIcons.message : MnIcons.video,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    final side = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RequestsBanner(count: pending, subtitle: 'Awaiting your response', onTap: () => goToTab(context, ProTab.requests)),
        const SizedBox(height: 20),
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: Text('Client engagement', style: context.text.title3)),
              const SizedBox(height: 16),
              MnDonut(
                value: d.engagement.toDouble(),
                size: 130,
                stroke: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${d.engagement}%', style: context.text.title1),
                    Text('active', style: context.text.cap.copyWith(color: c.ink3)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [Text('${d.activeClients}', style: context.text.title3), Text('Active clients', style: context.text.cap.copyWith(color: c.ink3))]),
                    Container(width: 1, margin: const EdgeInsets.symmetric(horizontal: 22), color: c.hairline),
                    Column(children: [Text('${d.newThisMonth}', style: context.text.title3), Text('New this month', style: context.text.cap.copyWith(color: c.ink3))]),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Session metrics', style: context.text.title3),
              const SizedBox(height: 14),
              MetricBar(label: 'Completed', percent: d.completedRate, color: c.green),
              MetricBar(label: 'Attendance', percent: d.attendanceRate, color: c.primary),
              MetricBar(label: 'Rebooked', percent: d.rebookedRate, color: c.clay),
            ],
          ),
        ),
      ],
    );

    return MnPage(
      maxWidth: 1180,
      padding: EdgeInsets.fromLTRB(context.gutter, 28, context.gutter, 44),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeUp(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('EEEE, d MMMM').format(DateTime.now()),
                          style: context.text.sub.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${_greeting()}, ${_drName(context)}', style: context.text.serif(size: 40, height: 1.08)),
                    ],
                  ),
                ),
                MnCard(
                  style: MnCardStyle.flat,
                  radius: 20,
                  padding: const EdgeInsets.fromLTRB(16, 6, 10, 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: MnMotion.base,
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: d.acceptingClients ? c.green : c.ink4,
                          boxShadow: d.acceptingClients ? [BoxShadow(color: c.green.withValues(alpha: .22), spreadRadius: 4)] : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(d.acceptingClients ? 'Accepting clients' : 'Unavailable', style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      MnToggle(value: d.acceptingClients, onChanged: context.read<DashboardCubit>().setAccepting),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ResponsiveGrid(
            columns: 4,
            spacing: 16,
            children: [
              StatTile(icon: MnIcons.calendar, value: '${d.sessionsToday}', label: 'Sessions today', delta: '+1'),
              StatTile(icon: MnIcons.trend, color: c.green, value: money(d.weekEarnings), label: 'This week', delta: '+18%'),
              StatTile(icon: MnIcons.star, color: MnColors.moss500, value: d.rating.toStringAsFixed(1), label: 'Avg. rating', delta: '+0.1'),
              StatTile(icon: MnIcons.pulse, color: c.clay, value: '${d.responseRate}%', label: 'Response rate', delta: '+4%'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(flex: 3, child: main), const SizedBox(width: 20), Expanded(flex: 2, child: side)],
          ),
        ],
      ),
    );
  }
}
