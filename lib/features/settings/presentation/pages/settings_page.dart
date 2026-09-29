import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/app_preferences.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_widgets.dart';
import 'legal_page.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Future<void> _requestDataExport(BuildContext context) async {
    final ok = await Adaptive.confirm(
      context,
      title: 'Request a copy of your data?',
      message: 'We\'ll open an email to our support team. Your export is sent to your account email.',
      confirmLabel: 'Continue',
    );
    if (!ok || !context.mounted) return;
    final email = context.read<AuthBloc>().state.user?.email ?? '';
    await ExternalLinks.email(
      context,
      subject: 'Data export request',
      body: 'Please send me a copy of my MindNest data.\n\nAccount email: $email',
    );
  }

  static Future<void> signOut(BuildContext context) async {
    final ok = await Adaptive.confirm(
      context,
      title: 'Log out of MindNest?',
      message: 'Your journal and check-ins stay safely stored.',
      confirmLabel: 'Log out',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    context.read<AuthBloc>().add(const AuthEvent.signedOut());
    context.router.replaceAll([const SplashRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<SettingsCubit, AppPreferences>(
      builder: (context, p) {
        final cubit = context.read<SettingsCubit>();
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return MnPage(
          header: const MnNavHeader(title: 'Settings'),
          maxWidth: 640,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MnGroup(
                title: 'Appearance',
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SettingIcon(icon: isDark ? MnIcons.moon : MnIcons.sun),
                            const SizedBox(width: 12),
                            Text('Theme', style: context.text.body.copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        MnSegmented<ThemeMode>(
                          options: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
                          value: p.themeMode,
                          labelOf: (m) => switch (m) {
                            ThemeMode.system => 'System',
                            ThemeMode.light => 'Light',
                            ThemeMode.dark => 'Dark',
                          },
                          onChanged: cubit.setThemeMode,
                        ),
                      ],
                    ),
                  ),
                  MnListRow(
                    title: 'Accessibility',
                    subtitle: 'Text size, motion & contrast',
                    leading: const SettingIcon(icon: MnIcons.eye),
                    onTap: () => context.router.push(const AccessibilityRoute()),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              MnGroup(
                title: 'Notifications',
                children: [
                  _toggleRow(context, MnIcons.heart, 'Daily mood reminders', p.dailyReminders, cubit.setDailyReminders),
                  _toggleRow(context, MnIcons.calendar, 'Session reminders', p.sessionReminders, cubit.setSessionReminders),
                  _toggleRow(context, MnIcons.message, 'New messages', p.messageAlerts, cubit.setMessageAlerts),
                  _toggleRow(context, MnIcons.mail, 'Content & email updates', p.contentUpdates, cubit.setContentUpdates),
                ],
              ),
              const SizedBox(height: 22),
              MnGroup(
                title: 'Privacy & security',
                children: [
                  MnListRow(
                    title: 'Privacy policy',
                    leading: const SettingIcon(icon: MnIcons.shield),
                    onTap: () => context.router.push(LegalRoute(doc: LegalDoc.privacy)),
                  ),
                  MnListRow(
                    title: 'Terms of use',
                    leading: const SettingIcon(icon: MnIcons.doc),
                    onTap: () => context.router.push(LegalRoute(doc: LegalDoc.terms)),
                  ),
                  MnListRow(title: 'Data & export', leading: const SettingIcon(icon: MnIcons.doc), onTap: () => _requestDataExport(context)),
                  MnListRow(
                    title: 'Blocked users',
                    leading: const SettingIcon(icon: MnIcons.block),
                    onTap: () => context.router.push(const BlockedUsersRoute()),
                  ),
                  MnListRow(
                    title: 'Delete account',
                    leading: const SettingIcon(icon: MnIcons.trash),
                    onTap: () => context.router.push(const DeleteAccountRoute()),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              MnGroup(
                title: 'Support',
                children: [
                  MnListRow(title: 'Help centre', leading: const SettingIcon(icon: MnIcons.info), onTap: () => ExternalLinks.open(context, LinkConfig.helpCentre)),
                  MnListRow(title: 'Contact us', leading: const SettingIcon(icon: MnIcons.message), onTap: () => ExternalLinks.email(context, subject: 'MindNest support')),
                ],
              ),
              const SizedBox(height: 22),
              CrisisCard(onCall: () => showCrisisSheet(context)),
              const SizedBox(height: 18),
              MnButton(
                label: 'Log out',
                icon: MnIcons.logout,
                variant: MnButtonVariant.danger,
                onPressed: () => signOut(context),
              ),
              const SizedBox(height: 18),
              Text('MindNest · 1.0.0', textAlign: TextAlign.center, style: context.text.cap.copyWith(color: c.ink3)),
            ],
          ),
        );
      },
    );
  }

  Widget _toggleRow(BuildContext context, MnIconData icon, String label, bool value, ValueChanged<bool> onChanged) =>
      MergeSemantics(
        child: MnListRow(
          title: label,
          leading: SettingIcon(icon: icon),
          showChevron: false,
          trailing: MnToggle(value: value, onChanged: onChanged),
        ),
      );
}
