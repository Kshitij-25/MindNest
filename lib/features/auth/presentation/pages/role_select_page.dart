import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/user_role.dart';
import '../bloc/auth_bloc.dart';

@RoutePage()
class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({super.key});

  void _choose(BuildContext context, UserRole role) {
    context.read<AuthBloc>().add(AuthEvent.roleSelected(role));
    context.router.push(LoginRoute(role: role));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnPage(
      maxWidth: 520,
      padding: EdgeInsets.fromLTRB(24, 40, 24, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeUp(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MnLogo(size: 50),
                const SizedBox(height: 22),
                Text('Welcome to MindNest', style: context.text.title1),
                const SizedBox(height: 8),
                Text(
                  'How would you like to use MindNest today?',
                  style: context.text.body.copyWith(color: c.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Stagger(
            spacing: 14,
            children: [
              _RoleCard(
                icon: MnIcons.heart,
                title: 'I’m seeking support',
                subtitle: 'Track your mood & connect with therapists',
                tint: c.primaryTint,
                color: c.primary,
                onTap: () => _choose(context, UserRole.client),
              ),
              _RoleCard(
                icon: MnIcons.award,
                title: 'I’m a professional',
                subtitle: 'Offer sessions & support your clients',
                tint: c.clayTint,
                color: c.clay,
                onTap: () => _choose(context, UserRole.professional),
              ),
            ],
          ),
        ],
      ),
      bottom: Text(
        'By continuing you agree to our Terms & Privacy Policy.',
        textAlign: TextAlign.center,
        style: context.text.foot.copyWith(color: c.ink3),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.color,
    required this.onTap,
  });

  final MnIconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return MnCard(
      onTap: onTap,
      semanticLabel: title,
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          IconTile(
            size: 60,
            radius: 18,
            color: tint,
            child: MnIcon(icon, size: 28, color: color, stroke: 1.9),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.title3),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: context.text.callout.copyWith(color: c.ink2),
                ),
              ],
            ),
          ),
          MnIcon(MnIcons.chevR, size: 20, color: c.ink4),
        ],
      ),
    );
  }
}
