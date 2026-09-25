import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/usecases/onboarding_usecases.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Assessment? _a;

  @override
  void initState() {
    super.initState();
    getIt<GetAssessment>()(const NoParams()).then((r) {
      if (mounted) setState(() => _a = r.getOrElse((_) => null));
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final a = _a ?? const Assessment();
    final focus = a.goals.isEmpty ? 'Anxiety · Sleep' : a.goals.take(2).join(' · ');
    final rows = [
      ('Mood', moodLabel(a.mood), MnIcons.heart),
      ('Focus areas', focus, MnIcons.sparkle),
      ('Check-ins', 'Daily reminders on', MnIcons.bell),
    ];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -.7),
            radius: 1.1,
            colors: [c.primaryTint, c.bg],
            stops: const [0, .5],
          ),
        ),
        child: MnPage(
          background: Colors.transparent,
          maxWidth: 480,
          padding: const EdgeInsets.fromLTRB(28, 56, 28, 24),
          body: Column(
            children: [
              SizedBox(
                width: 136,
                height: 136,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ripple(color: c.primaryRing, size: 136),
                    const PopIn(spring: false, child: Breathe(child: MnLogo(size: 96))),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              FadeUp(child: Text('You’re all set', style: context.text.title1)),
              const SizedBox(height: 10),
              FadeUp(
                delay: const Duration(milliseconds: 80),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Text(
                    'We’ve tailored MindNest around how you’re feeling. Take it one gentle step at a time.',
                    textAlign: TextAlign.center,
                    style: context.text.body.copyWith(color: c.ink2),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FadeUp(
                delay: const Duration(milliseconds: 160),
                child: MnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('YOUR STARTING POINT', style: context.text.cap.copyWith(color: c.ink3)),
                      const SizedBox(height: 12),
                      for (final r in rows)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              IconTile(size: 34, radius: 10, child: MnIcon(r.$3, size: 18, color: c.primary)),
                              const SizedBox(width: 12),
                              Expanded(child: Text(r.$1, style: context.text.callout.copyWith(color: c.ink2))),
                              Flexible(
                                child: Text(r.$2, style: context.text.headline, textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottom: MnButton(
            label: 'Enter MindNest',
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.onboardingCompleted());
              context.router.replaceAll([const ClientShellRoute()]);
            },
          ),
        ),
      ),
    );
  }
}
