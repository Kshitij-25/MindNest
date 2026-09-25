import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class ProVerifyPage extends StatelessWidget {
  const ProVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final name = context.select((AuthBloc b) => b.state.user?.name ?? '');
    final lastName = name.split(' ').last;
    const steps = [
      ('Documents received', 'Just now', 2),
      ('Identity check', 'In progress', 1),
      ('Credential review', 'Up to 48 hours', 0),
      ('You’re verified', 'Final step', 0),
    ];
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -.76),
            radius: 1.1,
            colors: [c.primaryTint, c.bg],
            stops: const [0, .45],
          ),
        ),
        child: MnPage(
          background: Colors.transparent,
          maxWidth: 480,
          padding: const EdgeInsets.fromLTRB(28, 60, 28, 24),
          body: Column(
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CircularProgressIndicator(strokeWidth: 2, color: c.primary, backgroundColor: c.primaryRing),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(color: c.primaryTint, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: MnIcon(MnIcons.shield, size: 38, color: c.primary, stroke: 1.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              FadeUp(child: Text('Verification in progress', style: context.text.title1, textAlign: TextAlign.center)),
              const SizedBox(height: 8),
              FadeUp(
                child: Text(
                  'Thanks, Dr. $lastName. Our team is reviewing your credentials — usually within 48 hours.',
                  textAlign: TextAlign.center,
                  style: context.text.body.copyWith(color: c.ink2),
                ),
              ),
              const SizedBox(height: 28),
              FadeUp(
                child: MnCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    children: [
                      for (final (i, st) in steps.indexed)
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                children: [
                                  _StepDot(state: st.$3),
                                  if (i < steps.length - 1)
                                    Expanded(
                                      child: Container(
                                        width: 2,
                                        margin: const EdgeInsets.only(top: 2),
                                        color: st.$3 == 2 ? c.primary : c.hairline,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2, bottom: i < steps.length - 1 ? 18 : 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(st.$1, style: context.text.headline.copyWith(color: st.$3 == 0 ? c.ink3 : c.ink)),
                                      const SizedBox(height: 2),
                                      Text(st.$2, style: context.text.foot.copyWith(color: c.ink3)),
                                    ],
                                  ),
                                ),
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
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MnButton(label: 'Preview my dashboard', onPressed: () => context.router.replaceAll([const ProShellRoute()])),
              const SizedBox(height: 10),
              MnButton.ghost(
                label: 'Back to start',
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signedOut());
                  context.router.replaceAll([const SplashRoute()]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.state});

  /// 2 = done, 1 = active, 0 = upcoming
  final int state;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: state == 2 ? c.primary : (state == 1 ? c.primaryTint : c.fill),
        border: state == 1 ? Border.all(color: c.primary, width: 2) : null,
      ),
      alignment: Alignment.center,
      child: switch (state) {
        2 => MnIcon(MnIcons.check, size: 15, color: c.onPrimary, stroke: 3),
        1 => Breathe(
            min: 1,
            max: 1.3,
            period: const Duration(milliseconds: 800),
            child: Container(width: 8, height: 8, decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle)),
          ),
        _ => Container(width: 6, height: 6, decoration: BoxDecoration(color: c.ink4, shape: BoxShape.circle)),
      },
    );
  }
}
