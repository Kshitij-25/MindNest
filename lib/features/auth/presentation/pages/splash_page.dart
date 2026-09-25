import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../bloc/auth_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _ready = false;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer(const Duration(milliseconds: 1400), () async {
      if (!mounted) return;
      final bloc = context.read<AuthBloc>();
      // Session restore may still be talking to Firebase.
      final auth = bloc.state.status == AuthStatus.unknown
          ? await bloc.stream.firstWhere((s) => s.status != AuthStatus.unknown)
          : bloc.state;
      if (!mounted) return;
      if (auth.status == AuthStatus.authenticated && auth.user != null) {
        context.router.replaceAll([homeRouteFor(auth.user!)]);
      } else {
        setState(() => _ready = true);
      }
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -.64),
            radius: 1.2,
            colors: [c.primaryTint, c.bg],
            stops: const [0, .55],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size.height * .2,
              child: Breathe(
                min: 1,
                max: 1.08,
                period: const Duration(seconds: 3),
                fade: true,
                child: _ring(c, 320),
              ),
            ),
            Positioned(
              top: size.height * .24,
              child: Breathe(
                min: 1,
                max: 1.08,
                period: const Duration(milliseconds: 3400),
                fade: true,
                child: _ring(c, 220),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PopIn(
                  spring: false,
                  child: Breathe(child: MnLogo(size: 92)),
                ),
                const SizedBox(height: 22),
                FadeUp(
                  child: Column(
                    children: [
                      Text('MindNest', style: context.text.serif(size: 40)),
                      const SizedBox(height: 4),
                      Text(
                        'A calmer space for your mind',
                        style: context.text.body.copyWith(color: c.ink2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 28,
              right: 28,
              bottom: MediaQuery.paddingOf(context).bottom + 48,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: AnimatedSwitcher(
                    duration: MnMotion.slow,
                    switchInCurve: MnMotion.easeOut,
                    child: _ready
                        ? FadeUp(
                            key: const ValueKey('cta'),
                            child: Column(
                              children: [
                                MnButton(
                                  label: 'Get started',
                                  onPressed: () => context.router.push(
                                    const RoleSelectRoute(),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Private & encrypted · You’re in control',
                                  style: context.text.foot.copyWith(
                                    color: c.ink3,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Padding(
                            key: ValueKey('loader'),
                            padding: EdgeInsets.only(bottom: 18),
                            child: AdaptiveLoader(),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ring(MnColors c, double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: c.hairline),
    ),
  );
}
