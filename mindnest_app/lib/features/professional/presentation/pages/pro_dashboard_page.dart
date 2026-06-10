import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/navigation/tab_scope.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/features/messaging/presentation/pages/chat_page.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/professional.dart';
import '../cubit/pro_dashboard_cubit.dart';

/// Professional dashboard (home) tab. Hosted inside the pro shell.
class ProDashboardPage extends StatelessWidget {
  const ProDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProDashboardCubit>()..load(),
    child: const _DashboardView(),
  );
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<ProDashboardCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 10, 20, 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tuesday, 3 June',
                      style: MnText.foot.copyWith(color: c.ink3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Good morning, Dr. Hale',
                      style: MnText.serif(size: 28, color: c.ink),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Avatar('Evelyn Hale', size: 46, photo: true),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: c.bg,
                        shape: BoxShape.circle,
                      ),
                      child: const Verified(size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ProDashboardCubit, ProDashboardState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading ||
                  state.status == ViewStatus.initial) {
                return const AppLoader();
              }
              if (state.status == ViewStatus.error) {
                return AppErrorView(
                  failure: state.failure!,
                  onRetry: cubit.load,
                );
              }
              return _Loaded(stats: state.stats!, today: state.todaySessions);
            },
          ),
        ),
      ],
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.stats, required this.today});
  final DashboardStats stats;
  final List<ProSession> today;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cards = [
      ('calendar', c.primary, stats.sessionsToday, 'Sessions today'),
      ('bell', c.clay, stats.newRequests, 'New requests'),
      ('star', c.moss500, stats.rating, 'Avg. rating'),
      ('trend', c.green, stats.weekEarnings, 'This week'),
    ];
    return NoGlow(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.55,
            children: [
              for (final s in cards)
                _StatCard(icon: s.$1, color: s.$2, value: s.$3, label: s.$4),
            ],
          ),
          const SizedBox(height: 14),
          MnCard(
            color: c.primary,
            onTap: () => TabScope.maybeOf(context)?.go('requests'),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: c.onPrimary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: MnIcon(
                    'bell',
                    size: 22,
                    color: c.onPrimary,
                    stroke: 2,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${stats.newRequests} booking requests',
                        style: MnText.headline.copyWith(color: c.onPrimary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Review and respond',
                        style: MnText.foot.copyWith(
                          color: c.onPrimary.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                MnIcon('chevR', size: 22, color: c.onPrimary, stroke: 2.2),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SectionHead(
            'Today’s sessions',
            action: 'Calendar',
            onAction: () => TabScope.maybeOf(context)?.go('requests'),
          ),
          for (final s in today) ...[
            _SessionCard(session: s),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });
  final String icon;
  final Color color;
  final String value, label;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      kind: MnCardKind.flat,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tint(color, 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: MnIcon(icon, size: 19, color: color, stroke: 1.9),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: MnText.title2.copyWith(color: c.ink)),
              const SizedBox(height: 1),
              Text(label, style: MnText.foot.copyWith(color: c.ink3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final ProSession session;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final s = session;
    final time = s.when.contains('·') ? s.when.split('·').last.trim() : s.when;
    final isVideo = s.type == 'Video';
    return MnCard(
      kind: MnCardKind.flat,
      onTap: () => context.pushNamed(
        RouteNames.chat,
        pathParameters: {'id': 'c1'},
        extra: ChatArgs(asProfessional: true, name: s.name),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: MnText.foot.copyWith(
                color: c.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(width: 0.5, height: 40, color: c.hairline),
          const SizedBox(width: 14),
          Avatar(s.name, size: 42, photo: true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.name,
                  style: MnText.headline.copyWith(color: c.ink, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  '${s.type} · ${s.mins} min',
                  style: MnText.foot.copyWith(color: c.ink3),
                ),
              ],
            ),
          ),
          NavBtn(
            icon: isVideo ? 'video' : 'message',
            iconSize: 20,
            stroke: 1.9,
            background: c.primaryTint,
            color: c.primary,
            onTap: () => context.pushNamed(
              RouteNames.chat,
              pathParameters: {'id': 'c1'},
              extra: ChatArgs(asProfessional: true, name: s.name),
            ),
          ),
        ],
      ),
    );
  }
}
