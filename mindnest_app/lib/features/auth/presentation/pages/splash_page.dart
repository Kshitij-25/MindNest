import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  bool _ready = false;

  late final AnimationController _ring = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  void dispose() {
    _ring.dispose();
    super.dispose();
  }

  void _go() {
    if (!_ready) return;
    // MVP 1 has only the wellness (user) role — skip role selection and go
    // straight to sign-in. Flip AppPhase.mvp1 to restore the role chooser.
    if (AppPhase.mvp1) {
      context.pushNamed(RouteNames.login, extra: UserRole.user);
    } else {
      context.pushNamed(RouteNames.roleSelect);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnScaffold(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.3),
          radius: 1.0,
          colors: [c.primaryTint, c.bg],
          stops: const [0, 0.6],
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _go,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _ring2(c, 320),
            _ring2(c, 220),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(size: 92),
                const SizedBox(height: 26),
                Text('MindNest', style: MnText.serif(size: 40, color: c.ink)),
                const SizedBox(height: 10),
                Text(
                  'A calmer space for your mind',
                  style: MnText.body.copyWith(color: c.ink2),
                ),
              ],
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: safeBottom(context) + 28,
              child: AnimatedOpacity(
                opacity: _ready ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: _ready
                    ? Column(
                        children: [
                          MnButton(label: 'Get started', onPressed: _go),
                          const SizedBox(height: 14),
                          Text(
                            'Private & encrypted · You’re in control',
                            style: MnText.foot.copyWith(color: c.ink3),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            if (!_ready)
              Positioned(
                bottom: safeBottom(context) + 40,
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: c.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _ring2(MnColors c, double size) => ScaleTransition(
    scale: Tween(
      begin: 0.92,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _ring, curve: Curves.easeInOut)),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: c.primaryRing, width: 1.5),
      ),
    ),
  );
}
