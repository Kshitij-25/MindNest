import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../feed/presentation/widgets/post_widgets.dart';
import '../../../mood/presentation/bloc/mood_bloc.dart';
import '../../../mood/presentation/widgets/mood_widgets.dart';
import '../../../notifications/presentation/bloc/notifications_bloc.dart';
import '../../../sessions/presentation/bloc/sessions_bloc.dart';
import '../../../sessions/presentation/widgets/appointment_card.dart';
import '../../../shell/presentation/shell_tabs.dart';
import '../../../therapists/presentation/widgets/therapist_widgets.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_widgets.dart';

const _prompt = 'What gave you a moment of calm today?';
const _tabletPrompt = 'What is one small thing that felt good today?';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeCubit>()..load()),
        BlocProvider.value(value: getIt<MoodBloc>()),
        BlocProvider.value(value: getIt<SessionsBloc>()),
        BlocProvider.value(value: getIt<NotificationsBloc>()),
      ],
      child: ResponsiveLayout(phone: (_) => const _PhoneHome(), tablet: (_) => const _TabletHome()),
    );
  }
}

class _PhoneHome extends StatelessWidget {
  const _PhoneHome();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final name = context.select((AuthBloc b) => b.state.user?.firstName ?? 'there');
    final unread = context.select((NotificationsBloc b) => b.state.hasUnread);
    final home = context.watch<HomeCubit>().state;
    final mood = context.watch<MoodBloc>().state.summary;
    final next = context.watch<SessionsBloc>().state.next;

    return MnPage(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeUp(
            child: LargeTitle(
              eyebrow: greeting(),
              title: 'Hello, $name',
              serif: true,
              trailing: BellButton(hasUnread: unread, onTap: () => context.router.push(const NotificationsRoute())),
            ),
          ),
          const SizedBox(height: 22),
          FadeUp(
            delay: const Duration(milliseconds: 60),
            child: MnCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      MoodFace(level: mood?.today?.level ?? 3, size: 60),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TODAY’S CHECK-IN', style: context.text.cap.copyWith(color: c.ink3)),
                            const SizedBox(height: 3),
                            Text(
                              mood?.today == null ? 'Not logged yet' : 'Feeling ${moodLabel(mood!.today!.level).toLowerCase()}',
                              style: context.text.title3,
                            ),
                          ],
                        ),
                      ),
                      MnButton.tonal(
                        label: mood?.today == null ? 'Log' : 'Update',
                        size: MnButtonSize.small,
                        expand: false,
                        onPressed: () => context.router.push(const MoodTrackRoute()),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 14), child: Hairline()),
                  Row(
                    children: [
                      Expanded(child: Text('This week', style: context.text.foot.copyWith(color: c.ink2, fontWeight: FontWeight.w600))),
                      MnLinkButton(label: 'Insights', onPressed: () => context.router.push(const MoodInsightsRoute())),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (mood != null) MoodStrip(levels: mood.week) else const SizedBox(height: 60),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 14, 0, 12), child: Hairline()),
                  Row(
                    children: [
                      IconTile(size: 32, radius: 10, color: c.streak.withValues(alpha: .16), child: MnIcon(MnIcons.flame, size: 18, color: c.streak, stroke: 1.9)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '${mood?.streak ?? 0} days', style: TextStyle(color: c.ink, fontWeight: FontWeight.w700)),
                              const TextSpan(text: ' of gentle check-ins'),
                            ],
                          ),
                          style: context.text.callout.copyWith(color: c.ink2),
                        ),
                      ),
                      Text('Keep going', style: context.text.foot.copyWith(color: c.ink3)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeUp(
            delay: const Duration(milliseconds: 120),
            child: ReflectionPrompt(prompt: _prompt, onTap: () => context.router.push(JournalWriteRoute(prompt: _prompt))),
          ),
          const SizedBox(height: 26),
          FadeUp(
            delay: const Duration(milliseconds: 160),
            child: Row(
              children: [
                Expanded(child: QuickAction(icon: MnIcons.heart, label: 'Track mood', onTap: () => context.router.push(const MoodTrackRoute()))),
                const SizedBox(width: 10),
                Expanded(child: QuickAction(icon: MnIcons.pen, label: 'Journal', onTap: () => goToTab(context, ClientTab.journal))),
                const SizedBox(width: 10),
                Expanded(child: QuickAction(icon: MnIcons.compass, label: 'Find care', onTap: () => context.router.push(const DiscoverRoute()))),
              ],
            ),
          ),
          const SizedBox(height: 26),
          SectionHeader(title: 'Upcoming session', action: 'All', onAction: () => context.router.push(const SessionsRoute())),
          if (next != null)
            FadeUp(
              child: AppointmentCard(
                appointment: next,
                onTap: () => context.router.push(const SessionsRoute()),
              ),
            )
          else
            MnCard(
              style: MnCardStyle.inset,
              child: Row(
                children: [
                  Expanded(child: Text('No sessions booked yet.', style: context.text.callout.copyWith(color: c.ink2))),
                  MnLinkButton(label: 'Find a therapist', onPressed: () => context.router.push(const DiscoverRoute())),
                ],
              ),
            ),
          const SizedBox(height: 26),
          SectionHeader(title: 'Recommended for you', action: 'See all', onAction: () => context.router.push(const DiscoverRoute())),
          SizedBox(
            height: 232,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: home.recommended.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) => TherapistMiniCard(
                therapist: home.recommended[i],
                onTap: () => context.router.push(TherapistProfileRoute(therapistId: home.recommended[i].id)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletHome extends StatelessWidget {
  const _TabletHome();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final user = context.select((AuthBloc b) => b.state.user);
    final home = context.watch<HomeCubit>().state;
    final moodState = context.watch<MoodBloc>().state;
    final mood = moodState.summary;
    final next = context.watch<SessionsBloc>().state.next;

    final colA = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MnCard(
          padding: EdgeInsets.zero,
          clip: true,
          radius: 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
                child: Row(
                  children: [
                    MnIcon(MnIcons.calendar, size: 18, color: c.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Next session', style: context.text.headline)),
                    if (next != null)
                      Text(
                        'In ${next.startsAt.difference(DateTime.now()).inDays} days',
                        style: context.text.cap.copyWith(color: c.primary, fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ),
              const Hairline(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: next == null
                    ? Text('No sessions booked yet.', style: context.text.callout.copyWith(color: c.ink2))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              MnAvatar(name: next.therapist.name, size: 52, photo: true),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(child: Text(next.therapist.name, style: context.text.headline)),
                                        const SizedBox(width: 5),
                                        const VerifiedBadge(size: 15),
                                      ],
                                    ),
                                    Text('${next.type.label} · ${next.minutes} min', style: context.text.sub.copyWith(color: c.ink2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          MnCard(
                            style: MnCardStyle.inset,
                            radius: 18,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: Row(
                              children: [
                                MnIcon(MnIcons.clock, size: 17, color: c.primary),
                                const SizedBox(width: 10),
                                Text(
                                  '${formatDay(next.startsAt)} · ${formatTime(next.startsAt)}',
                                  style: context.text.sub.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: MnButton(
                                  label: 'Join',
                                  icon: MnIcons.video,
                                  size: MnButtonSize.small,
                                  onPressed: () => context.router.push(ChatRoute(therapistId: next.therapist.id)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MnButton.secondary(
                                  label: 'Manage',
                                  size: MnButtonSize.small,
                                  onPressed: () => goToTab(context, ClientTab.sessions),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('This week', style: context.text.title3)),
                  MnLinkButton(label: 'Details', fontSize: 14, onPressed: () => context.router.push(const MoodInsightsRoute())),
                ],
              ),
              Text('Average mood trending ${((mood?.trendPercent ?? 0) >= 0) ? 'up' : 'down'}',
                  style: context.text.sub.copyWith(color: c.ink3)),
              const SizedBox(height: 12),
              if (mood != null)
                MnLineChart(
                  values: mood.week.map((e) => e.toDouble()).toList(),
                  height: 120,
                  labels: lastSevenDayInitials(),
                ),
            ],
          ),
        ),
      ],
    );

    final colB = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [c.primary, MnColors.moss700],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconTile(size: 38, radius: 11, color: Colors.white.withValues(alpha: .2), child: const MnIcon(MnIcons.pen, size: 19, color: Colors.white)),
                  const SizedBox(width: 10),
                  Text('TODAY’S PROMPT',
                      style: TextStyle(color: Colors.white.withValues(alpha: .85), fontWeight: FontWeight.w700, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 14),
              Text(_tabletPrompt, style: context.text.serif(size: 20, height: 1.3).copyWith(color: Colors.white)),
              const SizedBox(height: 16),
              Pressable(
                onTap: () => context.router.push(JournalWriteRoute(prompt: _tabletPrompt)),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: .92), borderRadius: BorderRadius.circular(MnRadii.xs)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MnIcon(MnIcons.feather, size: 16, color: c.isDark ? MnColors.moss700 : c.primary),
                      const SizedBox(width: 8),
                      Text('Start writing',
                          style: TextStyle(color: c.isDark ? MnColors.moss700 : c.primary, fontWeight: FontWeight.w600, fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _MiniStat(
                  top: MnDonut(
                    value: 84,
                    size: 64,
                    stroke: 8,
                    child: Text('84%', style: context.text.headline.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  title: 'Goals met',
                  sub: 'This week',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _MiniStat(
                  top: Row(
                    children: [
                      MnIcon(MnIcons.flame, size: 26, color: c.streak),
                      const SizedBox(width: 8),
                      Text('${mood?.streak ?? 0}', style: context.text.title1),
                    ],
                  ),
                  title: 'Day streak',
                  sub: 'Keep it going',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MnCard(
          radius: 22,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Recommended reading', style: context.text.title3),
              const SizedBox(height: 8),
              for (final (i, p) in home.reading.indexed)
                PostMiniRow(post: p, seed: i + 1, onTap: () => context.router.push(PostDetailRoute(postId: p.id))),
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
                      Text('${greeting()}, ${user?.firstName ?? ''}', style: context.text.serif(size: 40, height: 1.08)),
                      const SizedBox(height: 6),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Text(
                          'You’re on a ${mood?.streak ?? 0}-day streak. Here’s a gentle look at your week.',
                          style: context.text.body.copyWith(color: c.ink2),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    MnAvatar(name: user?.name ?? '', size: 56, photo: true, ring: true),
                    Positioned(
                      bottom: -2,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: c.streak,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: c.bg, width: 2),
                        ),
                        child: Text('${mood?.streak ?? 0}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          FadeUp(delay: const Duration(milliseconds: 60), child: _MoodCheckIn(state: moodState)),
          const SizedBox(height: 20),
          FadeUp(
            delay: const Duration(milliseconds: 120),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: colA), const SizedBox(width: 20), Expanded(child: colB)],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(
            title: 'Find your therapist',
            subtitle: 'Matched to your goals',
            action: 'See all',
            onAction: () => context.router.push(const DiscoverRoute()),
          ),
          ResponsiveGrid(
            columns: 3,
            spacing: 20,
            children: [
              for (final t in home.recommended)
                TherapistGridCard(therapist: t, onTap: () => context.router.push(TherapistProfileRoute(therapistId: t.id))),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.top, required this.title, required this.sub});
  final Widget top;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(20), boxShadow: MnShadows.sm(c)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          top,
          const SizedBox(height: 10),
          Text(title, style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
          Text(sub, style: context.text.cap.copyWith(color: c.ink3)),
        ],
      ),
    );
  }
}

/// Tablet inline mood check-in (five large faces).
class _MoodCheckIn extends StatelessWidget {
  const _MoodCheckIn({required this.state});
  final MoodState state;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final picked = state.justLogged ?? state.summary?.today?.level;
    final saved = state.justLogged != null;
    return MnCard(
      radius: 22,
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('How are you feeling?', style: context.text.title3),
                    const SizedBox(height: 2),
                    Text(
                      saved ? 'Saved — thank you for checking in' : 'Tap to log your mood for today',
                      style: context.text.sub.copyWith(color: c.ink3),
                    ),
                  ],
                ),
              ),
              if (saved)
                PopIn(
                  child: Row(
                    children: [
                      MnIcon(MnIcons.checkCircle, size: 18, color: c.green, stroke: 2.2),
                      const SizedBox(width: 6),
                      Text('Logged', style: TextStyle(color: c.green, fontWeight: FontWeight.w700, fontSize: 14)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var l = 1; l <= 5; l++)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: picked == l,
                    label: moodLabel(l),
                    excludeSemantics: true,
                    child: Pressable(
                      onTap: () => context.read<MoodBloc>().add(MoodEvent.quickLog(l)),
                      child: AnimatedScale(
                        scale: picked == l ? 1.04 : 1,
                        duration: MnMotion.base,
                        curve: MnMotion.easeSpring,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: picked == l ? c.primary : Colors.transparent, width: 2.5),
                              ),
                              child: MoodFace(level: l, size: 62, soft: picked != l),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              moodLabel(l),
                              style: context.text.cap.copyWith(color: picked == l ? c.ink : c.ink3, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
