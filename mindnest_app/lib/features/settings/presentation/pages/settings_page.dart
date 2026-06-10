import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../cubit/settings_cubit.dart';
import '../cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SettingsCubit>()..load(),
    child: const _SettingsView(),
  );
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final theme = context.watch<ThemeCubit>();
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(title: 'Settings', onBack: () => context.pop()),
          Expanded(
            child: NoGlow(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  final cubit = context.read<SettingsCubit>();
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
                    children: [
                      _group(context, 'Appearance', [
                        _customRow(
                          context,
                          icon: theme.isDark ? 'moon' : 'sun',
                          title: 'Theme',
                          trailing: SizedBox(
                            width: 140,
                            child: Segmented(
                              options: const ['Light', 'Dark'],
                              value: theme.isDark ? 'Dark' : 'Light',
                              onChanged: (v) => theme.setDark(v == 'Dark'),
                            ),
                          ),
                          last: true,
                        ),
                      ]),
                      if (state.flags.isNotEmpty) ...[
                        const SizedBox(height: 22),
                        _group(
                          context,
                          'AI features',
                          _flagRows(context, cubit, state),
                        ),
                      ],
                      const SizedBox(height: 22),
                      _group(context, 'Notifications', [
                        _toggleRow(
                          context,
                          icon: 'bell',
                          title: 'Push notifications',
                          value: state.push,
                          onChanged: cubit.setPush,
                        ),
                        _toggleRow(
                          context,
                          icon: 'heart',
                          title: 'Daily mood reminders',
                          value: state.reminders,
                          onChanged: cubit.setReminders,
                        ),
                        _toggleRow(
                          context,
                          icon: 'mail',
                          title: 'Email updates',
                          value: state.emails,
                          onChanged: cubit.setEmails,
                          last: true,
                        ),
                      ]),
                      const SizedBox(height: 22),
                      _group(context, 'Privacy & security', [
                        _toggleRow(
                          context,
                          icon: 'lock',
                          title: 'Face ID lock',
                          value: state.biometric,
                          onChanged: cubit.setBiometric,
                        ),
                        _chevronRow(
                          context,
                          icon: 'shield',
                          title: 'Privacy policy',
                        ),
                        _chevronRow(
                          context,
                          icon: 'doc',
                          title: 'Data & export',
                          last: true,
                        ),
                      ]),
                      const SizedBox(height: 22),
                      _group(context, 'Support', [
                        _chevronRow(
                          context,
                          icon: 'info',
                          title: 'Help centre',
                        ),
                        _chevronRow(
                          context,
                          icon: 'message',
                          title: 'Contact us',
                          last: true,
                        ),
                      ]),
                      const SizedBox(height: 22),
                      _crisisCard(context),
                      const SizedBox(height: 22),
                      MnButton(
                        label: 'Log out',
                        variant: MnVariant.secondary,
                        foreground: c.red,
                        leading: MnIcon(
                          'logout',
                          size: 19,
                          color: c.red,
                          stroke: 2,
                        ),
                        onPressed: () {
                          getIt<SessionService>().clear();
                          context.goNamed(RouteNames.splash);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Friendly label + icon for known feature-flag keys; others are prettified.
  static const _flagMeta = <String, (String, String)>{
    'enableJournalAi': ('AI journal analysis', 'sparkle'),
    'enableCoach': ('AI Coach', 'message'),
    'enableRecommendations': ('Recommendations', 'feather'),
    'enableWeeklyReport': ('Weekly wellness reports', 'doc'),
    'enablePatterns': ('Pattern detection', 'pulse'),
    'patternDetection': ('Pattern detection', 'pulse'),
    'dailyReminder': ('Daily reminder', 'clock'),
    'notifications': ('Notifications', 'bell'),
    'biometricLock': ('Face ID lock', 'lock'),
  };

  String _prettyFlag(String key) {
    final spaced = key
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .toLowerCase()
        .replaceFirst('enable ', '');
    return spaced.isEmpty
        ? key
        : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }

  List<Widget> _flagRows(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    final keys = state.flags.keys.toList()..sort();
    return [
      for (var i = 0; i < keys.length; i++)
        () {
          final key = keys[i];
          final meta = _flagMeta[key];
          return _toggleRow(
            context,
            icon: meta?.$2 ?? 'sparkle',
            title: meta?.$1 ?? _prettyFlag(key),
            value: state.flags[key] ?? false,
            onChanged: (v) => cubit.setFlag(key, v),
            last: i == keys.length - 1,
          );
        }(),
    ];
  }

  Widget _group(BuildContext context, String label, List<Widget> rows) {
    final c = context.c;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
          child: Text(
            label.toUpperCase(),
            style: MnText.cap.copyWith(color: c.ink3, letterSpacing: 0.4),
          ),
        ),
        MnCard(
          clip: true,
          padding: EdgeInsets.zero,
          child: Column(children: rows),
        ),
      ],
    );
  }

  Widget _iconTile(BuildContext context, String icon) {
    final c = context.c;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: c.primaryTint,
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: MnIcon(icon, size: 17, color: c.primary, stroke: 2),
    );
  }

  Widget _rowShell(
    BuildContext context, {
    required String icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
    bool last = false,
  }) {
    final c = context.c;
    Widget body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          _iconTile(context, icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: MnText.body.copyWith(color: c.ink)),
          ),
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
    if (onTap != null) body = Pressable(onTap: onTap, child: body);
    return Column(
      children: [
        body,
        if (!last) const Hairline(margin: EdgeInsets.only(left: 58)),
      ],
    );
  }

  Widget _customRow(
    BuildContext context, {
    required String icon,
    required String title,
    required Widget trailing,
    bool last = false,
  }) => _rowShell(
    context,
    icon: icon,
    title: title,
    trailing: trailing,
    last: last,
  );

  Widget _toggleRow(
    BuildContext context, {
    required String icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool last = false,
  }) => _rowShell(
    context,
    icon: icon,
    title: title,
    trailing: MnToggle(value: value, onChanged: onChanged),
    last: last,
  );

  Widget _chevronRow(
    BuildContext context, {
    required String icon,
    required String title,
    VoidCallback? onTap,
    bool last = false,
  }) {
    final c = context.c;
    return _rowShell(
      context,
      icon: icon,
      title: title,
      onTap: onTap ?? () {},
      trailing: MnIcon('chevR', size: 18, color: c.ink3, stroke: 2),
      last: last,
    );
  }

  Widget _crisisCard(BuildContext context) {
    final c = context.c;
    return MnCard(
      color: c.clayTint,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: c.clay,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const MnIcon(
              'phone',
              size: 20,
              color: Colors.white,
              stroke: 2,
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In crisis? You’re not alone',
                style: MnText.headline.copyWith(color: c.ink, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                'Reach 24/7 confidential support now.',
                style: MnText.foot.copyWith(color: c.ink2, height: 1.4),
              ),
            ],
          ),
          const Spacer(),
          MnButton(
            label: 'Call',
            small: true,
            expand: false,
            background: c.clay,
            foreground: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
