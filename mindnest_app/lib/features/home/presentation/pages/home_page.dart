import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/navigation/tab_scope.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/api/wellness_repo.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/sample/wellness_sample.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../cubit/home_cubit.dart';
import '../widgets/appointment_card.dart';
import '../widgets/therapist_mini.dart';

/// User dashboard. Tab content — the shell supplies the Scaffold + bottom bar.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<HomeCubit>()..load(),
    child: const _HomeView(),
  );
}

class _HomeView extends StatefulWidget {
  const _HomeView();
  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // Insights row data — loaded from the backend; sections appear once present.
  DashboardData? _dash;
  WellnessData? _score;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
    _loadScore();
  }

  Future<void> _loadDashboard() async {
    try {
      final d = await wellnessRepo.dashboard();
      if (mounted) setState(() => _dash = d);
    } catch (_) {}
  }

  Future<void> _loadScore() async {
    try {
      final s = await wellnessRepo.wellnessScore();
      if (mounted) setState(() => _score = s);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == ViewStatus.error) {
          return AppErrorView(
            failure: state.failure!,
            onRetry: context.read<HomeCubit>().load,
          );
        }
        if (state.status != ViewStatus.loaded) return const AppLoader();
        return NoGlow(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, safeTop(context) + 6, 20, 28),
            children: [
              _greeting(context, c),
              const SizedBox(height: 18),
              // MVP 1 — wellness-score hero
              if (AppPhase.mvp1 && _score != null) ...[
                _wellnessScore(context, c),
                const SizedBox(height: 16),
              ],
              _dailyMood(context, c, state),
              const SizedBox(height: 16),
              // MVP 1 — emotional profile
              if (AppPhase.mvp1 && (_dash?.emotions.isNotEmpty ?? false)) ...[
                _emotionalProfile(context, c),
                const SizedBox(height: 16),
              ],
              _journalNudge(context, c),
              const SizedBox(height: 18),
              _quickActions(context, c),
              const SizedBox(height: 24),
              // Full app — upcoming therapy session (hidden in MVP 1)
              if (!AppPhase.mvp1 &&
                  state.appointment != null &&
                  state.apptTherapist != null) ...[
                const SectionHead('Upcoming session'),
                AppointmentCard(
                  appointment: state.appointment!,
                  therapist: state.apptTherapist!,
                  onTap: () => context.pushNamed(
                    RouteNames.therapistProfile,
                    pathParameters: {'id': state.appointment!.therapistId},
                  ),
                ),
                const SizedBox(height: 24),
              ],
              if (AppPhase.mvp1) ...[
                // MVP 1 — wellness recommendation + latest insight
                if (_dash?.recommendation != null) ...[
                  _recommendationCard(context, c),
                  const SizedBox(height: 24),
                ],
                if (_dash?.latestInsight != null) _latestInsight(context, c),
              ] else ...[
                // Full app — recommended therapists (hidden in MVP 1)
                SectionHead(
                  'Recommended for you',
                  action: 'See all',
                  onAction: () => context.pushNamed(RouteNames.discover),
                ),
                SizedBox(
                  height: 214,
                  child: NoGlow(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.recommended.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final t = state.recommended[i];
                        return TherapistMini(
                          therapist: t,
                          onTap: () => context.pushNamed(
                            RouteNames.therapistProfile,
                            pathParameters: {'id': t.id},
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  String get _timeGreeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _greeting(BuildContext context, MnColors c) {
    final name = _dash?.displayName?.trim();
    final hello = (name == null || name.isEmpty) ? 'Hello' : 'Hello, $name';
    return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_timeGreeting, style: MnText.foot.copyWith(color: c.ink3)),
            const SizedBox(height: 4),
            Text(hello, style: MnText.serif(size: 30, color: c.ink)),
          ],
        ),
      ),
      NavBtn(
        icon: 'bell',
        iconSize: 20,
        stroke: 1.9,
        badge: true,
        onTap: () => context.pushNamed(RouteNames.notifications),
      ),
    ],
    );
  }

  Widget _dailyMood(BuildContext context, MnColors c, HomeState state) {
    final records = [
      for (var i = 0; i < state.week.length && i < _days.length; i++)
        (day: _days[i], level: state.week[i]),
    ];
    return MnCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MoodFace(level: _dash?.moodLevel ?? 3, size: 60),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (_dash?.hasCheckin ?? false)
                          ? 'TODAY’S CHECK-IN'
                          : 'CURRENT MOOD',
                      style: MnText.cap.copyWith(color: c.ink3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dash?.moodLabel ?? 'How are you feeling?',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MnText.title3.copyWith(color: c.ink),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              MnButton(
                label: (_dash?.hasCheckin ?? false) ? 'Update' : 'Check in',
                variant: MnVariant.tonal,
                small: true,
                expand: false,
                onPressed: () => context.pushNamed(RouteNames.moodTrack),
              ),
            ],
          ),
          const Hairline(margin: EdgeInsets.symmetric(vertical: 16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  'This week',
                  style: MnText.headline.copyWith(color: c.ink),
                ),
              ),
              LinkBtn(
                'Insights',
                fontSize: 14,
                onTap: () => context.pushNamed(RouteNames.moodInsights),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (records.isNotEmpty) MoodStrip(records),
          const Hairline(margin: EdgeInsets.symmetric(vertical: 16)),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: tint(c.streak, 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: MnIcon('flame', size: 20, color: c.streak, stroke: 1.9),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: MnText.callout.copyWith(color: c.ink2),
                        children: [
                          TextSpan(
                            text: '${_dash?.streakCurrent ?? 0} '
                                '${(_dash?.streakCurrent ?? 0) == 1 ? 'day' : 'days'}',
                            style: MnText.callout.copyWith(
                              color: c.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: ' of gentle check-ins'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (_dash?.streakCurrent ?? 0) == 0
                          ? 'Check in today to start a streak'
                          : 'Goal: ${_dash?.streakGoal ?? 7} days',
                      style: MnText.foot.copyWith(color: c.ink3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _journalNudge(BuildContext context, MnColors c) => Pressable(
    onTap: () => TabScope.maybeOf(context)?.go('journal'),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MnRadius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [c.primaryTint, c.surface],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(13),
            ),
            alignment: Alignment.center,
            child: MnIcon('feather', size: 21, color: c.primary, stroke: 1.9),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s reflection',
                  style: MnText.headline.copyWith(color: c.ink),
                ),
                const SizedBox(height: 3),
                Text(
                  'What is one small thing you are grateful for?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MnText.foot.copyWith(color: c.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          MnIcon('chevR', size: 18, color: c.ink3, stroke: 2),
        ],
      ),
    ),
  );

  Widget _quickActions(BuildContext context, MnColors c) => Row(
    children: [
      Expanded(
        child: _quickAction(
          context,
          c,
          'heart',
          'Track mood',
          () => context.pushNamed(RouteNames.moodTrack),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _quickAction(
          context,
          c,
          'pen',
          'Journal',
          () => TabScope.maybeOf(context)?.go('journal'),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: AppPhase.mvp1
            ? _quickAction(
                context,
                c,
                'compass',
                'Insights',
                () => context.pushNamed(RouteNames.insightsHub),
              )
            : _quickAction(
                context,
                c,
                'compass',
                'Find care',
                () => context.pushNamed(RouteNames.discover),
              ),
      ),
    ],
  );

  // ── MVP 1 insights elements ───────────────────────────────────────────────

  Widget _wellnessScore(BuildContext context, MnColors c) {
    final w = _score!;
    return MnCard(
      onTap: () => context.pushNamed(RouteNames.wellnessScore),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              RadialScore(
                value: w.score.toDouble(),
                size: 108,
                stroke: 10,
                sub: 'of 100',
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WELLNESS SCORE',
                      style: MnText.cap.copyWith(color: c.ink3, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 3),
                    Text(w.band, style: MnText.title2.copyWith(color: c.ink)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        TrendPill(
                          dir: TrendDir.up,
                          label: '+${w.weeklyChange} this week',
                        ),
                        Confidence(value: w.confidence, small: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Hairline(margin: EdgeInsets.fromLTRB(0, 16, 0, 12)),
          Row(
            children: [
              Expanded(child: Spark(data: w.spark)),
              const SizedBox(width: 10),
              Row(
                children: [
                  Text(
                    'Breakdown',
                    style: MnText.foot.copyWith(
                      color: c.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  MnIcon('chevR', size: 16, color: c.primary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emotionalProfile(BuildContext context, MnColors c) {
    final top = _dash!.emotions.take(4).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHead(
          'Emotional profile',
          action: 'View all',
          onAction: () => context.pushNamed(RouteNames.emotionalProfile),
        ),
        MnCard(
          onTap: () => context.pushNamed(RouteNames.emotionalProfile),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (final e in top)
                EmotionBar(
                  label: e.key,
                  value: e.value,
                  color: context.token(e.color),
                  trend: e.trend,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recommendationCard(BuildContext context, MnColors c) {
    final r = _dash!.recommendation!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHead(
          'Recommended for you',
          action: 'See all',
          onAction: () => context.pushNamed(RouteNames.recommendations),
        ),
        MnCard(
          onTap: () => context.pushNamed(RouteNames.recommendations),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(icon: r.icon, color: context.token(r.color), size: 46),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.kind.toUpperCase(),
                      style: MnText.cap.copyWith(
                        color: context.token(r.color),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(r.title, style: MnText.headline.copyWith(color: c.ink)),
                    const SizedBox(height: 5),
                    Text(r.reason, style: MnText.foot.copyWith(color: c.ink2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _latestInsight(BuildContext context, MnColors c) {
    return MnCard(
      onTap: () => context.pushNamed(RouteNames.insightsHub),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          IconTile(icon: 'sparkle', color: c.topic[3], size: 46),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LATEST INSIGHT',
                  style: MnText.cap.copyWith(color: c.ink3),
                ),
                const SizedBox(height: 4),
                Text(
                  _dash!.latestInsight!,
                  style: MnText.headline.copyWith(color: c.ink),
                ),
              ],
            ),
          ),
          MnIcon('chevR', size: 20, color: c.ink4),
        ],
      ),
    );
  }

  Widget _quickAction(
    BuildContext context,
    MnColors c,
    String icon,
    String label,
    VoidCallback onTap,
  ) => MnCard(
    kind: MnCardKind.flat,
    onTap: onTap,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    child: Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: c.primaryTint,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: MnIcon(icon, size: 21, color: c.primary, stroke: 1.9),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: MnText.foot.copyWith(
            color: c.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
