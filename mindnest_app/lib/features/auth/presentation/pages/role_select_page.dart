import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({super.key});

  void _choose(BuildContext context, UserRole role) {
    getIt<SessionService>().role = role.wire;
    context.pushNamed(RouteNames.login, extra: role);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnScaffold(
      child: NoGlow(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, safeTop(context) + 24, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Logo(size: 50, breathe: true),
              const SizedBox(height: 24),
              Text(
                'Welcome to MindNest',
                textAlign: TextAlign.center,
                style: MnText.title1.copyWith(color: c.ink),
              ),
              const SizedBox(height: 10),
              Text(
                'How would you like to get started?',
                textAlign: TextAlign.center,
                style: MnText.body.copyWith(color: c.ink2),
              ),
              const SizedBox(height: 32),
              _RoleCard(
                icon: 'heart',
                tile: c.primaryTint,
                tint: c.primary,
                title: 'I’m seeking support',
                sub: 'Track moods, journal, and connect with professionals.',
                onTap: () => _choose(context, UserRole.user),
              ),
              const SizedBox(height: 14),
              _RoleCard(
                icon: 'award',
                tile: c.clayTint,
                tint: c.clay,
                title: 'I’m a professional',
                sub: 'Offer sessions, manage requests, and share guidance.',
                onTap: () => _choose(context, UserRole.professional),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'By continuing you agree to our Terms & Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: MnText.foot.copyWith(color: c.ink3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.tile,
    required this.tint,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  final String icon;
  final Color tile;
  final Color tint;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      onTap: onTap,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: tile,
              borderRadius: BorderRadius.circular(MnRadius.sm),
            ),
            alignment: Alignment.center,
            child: MnIcon(icon, size: 24, color: tint, stroke: 1.9),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: MnText.title3.copyWith(color: c.ink)),
                const SizedBox(height: 3),
                Text(sub, style: MnText.callout.copyWith(color: c.ink2)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          MnIcon('chevR', size: 20, color: c.ink4, stroke: 2),
        ],
      ),
    );
  }
}
