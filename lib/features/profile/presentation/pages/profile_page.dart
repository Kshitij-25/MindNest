import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../journal/presentation/bloc/journal_bloc.dart';
import '../../../mood/presentation/bloc/mood_bloc.dart';
import '../../../mood/presentation/widgets/mood_widgets.dart';
import '../../../practice/presentation/bloc/dashboard_cubit.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../shell/presentation/shell_tabs.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc b) => b.state.user);
    if (user == null) return const SizedBox.shrink();
    return user.isProfessional ? _ProProfile(user: user) : _ClientProfile(user: user);
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => MnPage(
        maxWidth: 640,
        padding: EdgeInsets.fromLTRB(context.gutter, 16, context.gutter, 24),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LargeTitle(
              title: 'Profile',
              trailing: MnIconButton(
                icon: MnIcons.sliders,
                tooltip: 'Settings',
                iconSize: 20,
                stroke: 1.9,
                onPressed: () => context.router.push(const SettingsRoute()),
              ),
            ),
            const SizedBox(height: 24),
            ...children,
            const SizedBox(height: 18),
            MnButton(label: 'Log out', icon: MnIcons.logout, variant: MnButtonVariant.danger, onPressed: () => SettingsPage.signOut(context)),
            const SizedBox(height: 18),
            Text('MindNest · 1.0.0', textAlign: TextAlign.center, style: context.text.cap.copyWith(color: context.colors.ink3)),
          ],
        ),
      );
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.user, required this.subtitle, required this.stats});
  final AppUser user;
  final String subtitle;
  final List<(String, String)> stats;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return FadeUp(
      child: MnCard(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                MnAvatar(name: user.name, size: 84, ring: true, photo: user.isProfessional),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Semantics(
                    button: true,
                    label: 'Change photo',
                    child: Pressable(
                      onTap: () => context.router.push(const EditProfileRoute()),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: c.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: c.surface, width: 3),
                        ),
                        alignment: Alignment.center,
                        child: MnIcon(MnIcons.camera, size: 14, color: c.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text(user.name, style: context.text.title3)),
                if (user.isProfessional) ...[const SizedBox(width: 6), const VerifiedBadge(size: 18)],
              ],
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: context.text.callout.copyWith(color: c.ink2)),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                children: [
                  for (final (i, st) in stats.indexed) ...[
                    if (i > 0) Container(width: 1, color: c.hairline),
                    Expanded(
                      child: Column(
                        children: [
                          Text(st.$1, style: context.text.title3.copyWith(color: c.primary)),
                          const SizedBox(height: 2),
                          Text(st.$2, style: context.text.cap.copyWith(color: c.ink3)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({required this.items});
  final List<(MnIconData, String, VoidCallback)> items;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          for (final it in items)
            MnListRow(
              title: it.$2,
              leading: IconTile(size: 38, radius: 11, child: MnIcon(it.$1, size: 19, color: c.primary, stroke: 1.9)),
              onTap: it.$3,
            ),
        ],
      ),
    );
  }
}

class _ClientProfile extends StatelessWidget {
  const _ClientProfile({required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<MoodBloc>()..add(const MoodEvent.load())),
        BlocProvider.value(value: getIt<JournalBloc>()..add(const JournalEvent.load())),
      ],
      child: Builder(builder: (context) {
        final mood = context.watch<MoodBloc>().state.summary;
        final entries = context.watch<JournalBloc>().state.entries;
        final weekEntries = entries.where((e) => DateTime.now().difference(e.createdAt).inDays < 7).length;
        final activity = [
          (MnIcons.heart, '${mood?.recent.where((e) => DateTime.now().difference(e.createdAt).inDays < 7).length ?? 0}', 'Check-ins', c.clay),
          (MnIcons.feather, '$weekEntries', 'Journal entries', c.topics[3]),
          (MnIcons.calendar, '1', 'Session', c.primary),
          (MnIcons.layers, '9', 'Reads', c.topics[0]),
        ];
        return _Scaffold(
          children: [
            _IdentityCard(
              user: user,
              subtitle: user.email,
              stats: [('${mood?.month.length ?? 0}', 'Check-ins'), ('${entries.length}', 'Entries'), ('${mood?.streak ?? 0}', 'Day streak')],
            ),
            const SizedBox(height: 18),
            SectionHeader(title: 'This week', action: 'Insights', onAction: () => context.router.push(const MoodInsightsRoute())),
            MnCard(
              child: Column(
                children: [
                  ResponsiveGrid(
                    columns: 2,
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      for (final a in activity)
                        Row(
                          children: [
                            IconTile(size: 38, radius: 11, color: a.$4.withValues(alpha: .14), child: MnIcon(a.$1, size: 18, color: a.$4)),
                            const SizedBox(width: 11),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(a.$2, style: context.text.headline), Text(a.$3, style: context.text.cap.copyWith(color: c.ink3))],
                            ),
                          ],
                        ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Hairline()),
                  if (mood != null) MoodStrip(levels: mood.week),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _Menu(items: [
              (MnIcons.trend, 'Mood insights', () => context.router.push(const MoodInsightsRoute())),
              (MnIcons.calendar, 'My sessions', () => openSection(context, const SessionsRoute(), ClientTab.sessions)),
              (MnIcons.bookOpen, 'My journal', () => goToTab(context, ClientTab.journal)),
              (MnIcons.bookmark, 'Saved posts', () => context.router.push(FeedRoute(savedOnly: true))),
              (MnIcons.edit, 'Edit profile', () => context.router.push(const EditProfileRoute())),
              (MnIcons.bell, 'Notifications', () => context.router.push(const NotificationsRoute())),
              (MnIcons.sliders, 'Settings', () => context.router.push(const SettingsRoute())),
            ]),
          ],
        );
      }),
    );
  }
}

class _ProProfile extends StatelessWidget {
  const _ProProfile({required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider.value(
      value: getIt<DashboardCubit>()..load(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, s) {
          final d = s.data;
          final accepting = d?.acceptingClients ?? true;
          return _Scaffold(
            children: [
              _IdentityCard(
                user: user,
                subtitle: '${user.title ?? 'Therapist'} · ${d?.years ?? 0} yrs',
                stats: [('${d?.totalClients ?? '–'}', 'Clients'), (d?.rating.toStringAsFixed(1) ?? '–', 'Rating'), ('${d?.responseRate ?? '–'}%', 'Response')],
              ),
              const SizedBox(height: 18),
              MnCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: MergeSemantics(
                  child: Row(
                    children: [
                      IconTile(
                        size: 38,
                        radius: 11,
                        color: accepting ? c.primaryTint : c.fill,
                        child: MnIcon(MnIcons.pulse, size: 19, color: accepting ? c.primary : c.ink3),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Accepting clients', style: context.text.headline),
                            Text(accepting ? 'Visible in discovery' : 'Hidden from search', style: context.text.foot.copyWith(color: c.ink3)),
                          ],
                        ),
                      ),
                      MnToggle(value: accepting, onChanged: context.read<DashboardCubit>().setAccepting),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Menu(items: [
                (MnIcons.calendar, 'Manage availability', () => openSection(context, const ProCalendarRoute(), ProTab.calendar)),
                (MnIcons.users, 'Clients & notes', () => openSection(context, const ProClientsRoute(), ProTab.clients)),
                (MnIcons.award, 'Credentials & verification', () => context.router.push(const ProCredentialsRoute())),
                (MnIcons.trend, 'Earnings & payouts', () => openSection(context, const ProEarningsRoute(), ProTab.earnings)),
                (MnIcons.edit, 'Edit profile', () => context.router.push(const EditProfileRoute())),
                (MnIcons.sliders, 'Settings', () => context.router.push(const SettingsRoute())),
              ]),
            ],
          );
        },
      ),
    );
  }
}
