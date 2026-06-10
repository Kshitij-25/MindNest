import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final rows = [
      ('heart', 'Mood', 'Good'),
      ('sparkle', 'Focus areas', 'Anxiety · Sleep'),
      ('bell', 'Check-ins', 'Daily reminders on'),
    ];
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
                padding: EdgeInsets.fromLTRB(24, safeTop(context) + 36, 24, 0),
                children: [
                  FadeUp(
                    child: Column(
                      children: [
                        const _RipplingLogo(),
                        const SizedBox(height: 30),
                        Text(
                          'You’re all set',
                          style: MnText.title1.copyWith(color: c.ink),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Text(
                            'Your space is ready. We’ve tailored MindNest around what you shared — come as you are, anytime.',
                            textAlign: TextAlign.center,
                            style: MnText.body.copyWith(color: c.ink2),
                          ),
                        ),
                        const SizedBox(height: 34),
                        MnCard(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'YOUR STARTING POINT',
                                style: MnText.cap.copyWith(color: c.ink3),
                              ),
                              const SizedBox(height: 6),
                              for (var i = 0; i < rows.length; i++) ...[
                                _StartingRow(
                                  icon: rows[i].$1,
                                  label: rows[i].$2,
                                  value: rows[i].$3,
                                ),
                                if (i != rows.length - 1)
                                  const Hairline(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                  ),
                              ],
                            ],
                          ),
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
            child: MnButton(
              label: 'Enter MindNest',
              onPressed: () => context.goNamed(RouteNames.userShell),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartingRow extends StatelessWidget {
  const _StartingRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final String icon, label, value;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: c.primaryTint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: MnIcon(icon, size: 19, color: c.primary, stroke: 1.9),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(label, style: MnText.callout.copyWith(color: c.ink2)),
          ),
          Text(value, style: MnText.headline.copyWith(color: c.ink)),
        ],
      ),
    );
  }
}

/// App logo with a soft, repeating ripple ring behind it.
class _RipplingLogo extends StatefulWidget {
  const _RipplingLogo();
  @override
  State<_RipplingLogo> createState() => _RipplingLogoState();
}

class _RipplingLogoState extends State<_RipplingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ripple = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  )..repeat();

  @override
  void dispose() {
    _ripple.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _ripple,
            builder: (_, _) {
              final t = _ripple.value;
              return Transform.scale(
                scale: 0.6 + t * 1.0,
                child: Opacity(
                  opacity: (0.4 * (1 - t)).clamp(0.0, 1.0),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: c.primaryRing,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          const Logo(size: 96),
        ],
      ),
    );
  }
}
