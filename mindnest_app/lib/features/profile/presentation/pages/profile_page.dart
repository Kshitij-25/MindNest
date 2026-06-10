import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/navigation/tab_scope.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/user_profile.dart';
import '../cubit/profile_cubit.dart';

/// Profile tab — rendered inside the user shell (no Scaffold of its own).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProfileCubit>()..load(),
    child: const _ProfileView(),
  );
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  Color _activityColor(MnColors c, String key) => switch (key) {
    'clay' => c.clay,
    'topic4' => c.topic[3],
    'primary' => c.primary,
    'topic1' => c.topic[0],
    _ => c.primary,
  };

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == ViewStatus.error) {
          return AppErrorView(
            failure: state.failure!,
            onRetry: context.read<ProfileCubit>().load,
          );
        }
        final p = state.profile;
        if (p == null) return const AppLoader();
        return NoGlow(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 30),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Profile',
                      style: MnText.title1.copyWith(color: c.ink),
                    ),
                  ),
                  NavBtn(
                    icon: 'sliders',
                    iconSize: 20,
                    stroke: 1.9,
                    onTap: () => context.pushNamed(RouteNames.settings),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _ProfileCard(profile: p),
              const SizedBox(height: 22),
              SectionHead(
                'This week',
                action: 'Insights',
                onAction: () => context.pushNamed(RouteNames.moodInsights),
              ),
              MnCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        for (final a in p.weekActivity)
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width -
                                    40 -
                                    36 -
                                    14) /
                                2,
                            child: _ActivityTile(
                              activity: a,
                              color: _activityColor(c, a.colorKey),
                            ),
                          ),
                      ],
                    ),
                    const Hairline(margin: EdgeInsets.symmetric(vertical: 16)),
                    SizedBox(
                      height: 80,
                      child: MoodStrip([
                        for (var i = 0; i < p.moodWeek.length; i++)
                          (day: _days[i], level: p.moodWeek[i]),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              MnCard(
                kind: MnCardKind.flat,
                padding: EdgeInsets.zero,
                clip: true,
                child: Column(
                  children: [
                    _MenuRow(
                      icon: 'trend',
                      label: 'Mood insights',
                      onTap: () => context.pushNamed(RouteNames.moodInsights),
                    ),
                    const Hairline(),
                    // MVP 1 — insights suite entries
                    if (AppPhase.mvp1) ...[
                      _MenuRow(
                        icon: 'compass',
                        label: 'Insights hub',
                        onTap: () => context.pushNamed(RouteNames.insightsHub),
                      ),
                      const Hairline(),
                      _MenuRow(
                        icon: 'target',
                        label: 'Habits',
                        onTap: () => context.pushNamed(RouteNames.habits),
                      ),
                      const Hairline(),
                    ],
                    _MenuRow(
                      icon: 'bookOpen',
                      label: 'My journal',
                      onTap: () => TabScope.maybeOf(context)?.go('journal'),
                    ),
                    const Hairline(),
                    _MenuRow(
                      icon: 'bookmark',
                      label: AppPhase.mvp1 ? 'Saved articles' : 'Saved posts',
                      onTap: () => TabScope.maybeOf(context)?.go('feed'),
                    ),
                    const Hairline(),
                    _MenuRow(
                      icon: 'edit',
                      label: 'Edit profile',
                      onTap: () => context.pushNamed(RouteNames.editProfile),
                    ),
                    const Hairline(),
                    _MenuRow(
                      icon: 'bell',
                      label: 'Notifications',
                      onTap: () => context.pushNamed(RouteNames.notifications),
                    ),
                    const Hairline(),
                    _MenuRow(
                      icon: 'sliders',
                      label: 'Settings',
                      onTap: () => context.pushNamed(RouteNames.settings),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              MnButton(
                label: 'Log out',
                variant: MnVariant.secondary,
                foreground: c.red,
                leading: MnIcon('logout', size: 19, color: c.red, stroke: 1.9),
                onPressed: () {
                  getIt<SessionService>().clear();
                  context.goNamed(RouteNames.splash);
                },
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  'MindNest V2 · 2.0.0',
                  style: MnText.cap.copyWith(color: c.ink4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Avatar(profile.name, size: 84, ring: true),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: c.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: c.surface, width: 2.5),
                  ),
                  alignment: Alignment.center,
                  child: MnIcon(
                    'camera',
                    size: 15,
                    color: c.onPrimary,
                    stroke: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(profile.name, style: MnText.title3.copyWith(color: c.ink)),
          const SizedBox(height: 3),
          Text(profile.email, style: MnText.callout.copyWith(color: c.ink2)),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(value: profile.checkIns, label: 'Check-ins'),
              _statDivider(c),
              _Stat(value: profile.entries, label: 'Entries'),
              _statDivider(c),
              _Stat(value: profile.streak, label: 'Day streak'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statDivider(MnColors c) =>
      Container(width: 1, height: 30, color: c.hairline);
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value, label;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Expanded(
      child: Column(
        children: [
          Text(value, style: MnText.title2.copyWith(color: c.primary)),
          const SizedBox(height: 3),
          Text(label, style: MnText.cap.copyWith(color: c.ink3)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity, required this.color});
  final ({String icon, String value, String label, String colorKey}) activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: tint(color, 0.14),
            borderRadius: BorderRadius.circular(13),
          ),
          alignment: Alignment.center,
          child: MnIcon(activity.icon, size: 20, color: color, stroke: 1.9),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                activity.value,
                style: MnText.headline.copyWith(color: c.ink),
              ),
              const SizedBox(height: 1),
              Text(
                activity.label,
                style: MnText.cap.copyWith(color: c.ink3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label, this.onTap});
  final String icon, label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Pressable(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            MnIcon(icon, size: 21, color: c.ink2, stroke: 1.9),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: MnText.body.copyWith(color: c.ink)),
            ),
            MnIcon('chevR', size: 18, color: c.ink4, stroke: 2),
          ],
        ),
      ),
    );
  }
}
