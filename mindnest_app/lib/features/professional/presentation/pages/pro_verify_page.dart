import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

class _Step {
  const _Step(this.title, this.sub, this.state);
  final String title, sub, state; // state: done | active | pending
}

class ProVerifyPage extends StatelessWidget {
  const ProVerifyPage({super.key});

  static const _steps = [
    _Step('Documents received', 'Just now', 'done'),
    _Step('Identity check', 'In progress', 'active'),
    _Step('Credential review', 'Up to 48 hours', 'pending'),
    _Step('You’re verified', 'Final step', 'pending'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnScaffold(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.7),
          radius: 0.95,
          colors: [c.primaryTint, c.bg],
          stops: const [0, 0.5],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: EdgeInsets.fromLTRB(24, safeTop(context) + 24, 24, 0),
                children: [
                  const Center(child: _SpinningRing()),
                  const SizedBox(height: 26),
                  Text(
                    'Verification in progress',
                    textAlign: TextAlign.center,
                    style: MnText.title1.copyWith(color: c.ink),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thanks, Dr. Hale. Our team is reviewing your documents. We’ll notify you the moment you’re verified — usually within 48 hours.',
                    textAlign: TextAlign.center,
                    style: MnText.body.copyWith(color: c.ink2),
                  ),
                  const SizedBox(height: 28),
                  MnCard(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: Column(
                      children: [
                        for (var i = 0; i < _steps.length; i++)
                          _TimelineRow(
                            step: _steps[i],
                            last: i == _steps.length - 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, safeBottom(context) + 16),
            child: Column(
              children: [
                MnButton(
                  label: 'Preview my dashboard',
                  onPressed: () => context.goNamed(RouteNames.proShell),
                ),
                const SizedBox(height: 10),
                MnButton(
                  label: 'Back to start',
                  variant: MnVariant.ghost,
                  onPressed: () => context.goNamed(RouteNames.splash),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpinningRing extends StatefulWidget {
  const _SpinningRing();
  @override
  State<_SpinningRing> createState() => _SpinningRingState();
}

class _SpinningRingState extends State<_SpinningRing> {
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: CircularProgressIndicator(
              strokeWidth: 3.5,
              color: c.primary,
              backgroundColor: c.primaryRing,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: c.primaryTint,
              borderRadius: BorderRadius.circular(19),
            ),
            alignment: Alignment.center,
            child: MnIcon('shield', size: 28, color: c.primary, stroke: 1.9),
          ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.step, required this.last});
  final _Step step;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final (Color dot, Color line) = switch (step.state) {
      'done' => (c.green, c.green),
      'active' => (c.primary, c.hairline2),
      _ => (c.hairline2, c.hairline2),
    };
    final pending = step.state == 'pending';
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: step.state == 'active'
                      ? c.primaryTint
                      : (step.state == 'done' ? c.green : Colors.transparent),
                  shape: BoxShape.circle,
                  border: Border.all(color: dot, width: 2),
                ),
                alignment: Alignment.center,
                child: step.state == 'done'
                    ? MnIcon('check', size: 12, color: c.onPrimary, stroke: 3)
                    : (step.state == 'active'
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: c.primary,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null),
              ),
              if (!last) Expanded(child: Container(width: 2, color: line)),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 1, bottom: last ? 12 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: MnText.headline.copyWith(
                      color: pending ? c.ink3 : c.ink,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(step.sub, style: MnText.foot.copyWith(color: c.ink3)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
