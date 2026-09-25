import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Fade + rise entrance (`.anim-up`). Respects reduced motion.
class FadeUp extends StatefulWidget {
  const FadeUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 550),
    this.offset = 14,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  State<FadeUp> createState() => _FadeUpState();
}

class _FadeUpState extends State<FadeUp> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: widget.duration);
  late final _a = CurvedAnimation(parent: _c, curve: MnMotion.easeOut);

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _c.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _c.forward();
      });
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return AnimatedBuilder(
      animation: _a,
      builder: (context, child) => Opacity(
        opacity: _a.value.clamp(0, 1),
        child: Transform.translate(offset: Offset(0, widget.offset * (1 - _a.value)), child: child),
      ),
      child: widget.child,
    );
  }
}

/// Wraps each child in a [FadeUp] with a staggered delay (`.stagger`).
class Stagger extends StatelessWidget {
  const Stagger({
    super.key,
    required this.children,
    this.step = const Duration(milliseconds: 60),
    this.initial = const Duration(milliseconds: 40),
    this.spacing = 0,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final Duration step;
  final Duration initial;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0 && spacing > 0) SizedBox(height: spacing),
          FadeUp(delay: initial + step * math.min(i, 8), child: children[i]),
        ],
      ],
    );
  }
}

/// Scale-in pop (`popIn` / `.anim-scale`).
class PopIn extends StatefulWidget {
  const PopIn({super.key, required this.child, this.delay = Duration.zero, this.spring = true});

  final Widget child;
  final Duration delay;
  final bool spring;

  @override
  State<PopIn> createState() => _PopInState();
}

class _PopInState extends State<PopIn> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    final curve = widget.spring ? MnMotion.easeSpring : MnMotion.easeOut;
    final start = widget.spring ? 0.6 : 0.92;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = curve.transform(_c.value);
        return Opacity(
          opacity: Curves.easeOut.transform(_c.value),
          child: Transform.scale(scale: start + (1 - start) * t, child: child),
        );
      },
      child: widget.child,
    );
  }
}

/// Gentle infinite breathing scale (`breatheSlow`).
class Breathe extends StatefulWidget {
  const Breathe({
    super.key,
    required this.child,
    this.min = 0.96,
    this.max = 1.06,
    this.period = const Duration(seconds: 5),
    this.fade = false,
  });

  final Widget child;
  final double min;
  final double max;
  final Duration period;
  final bool fade;

  @override
  State<Breathe> createState() => _BreatheState();
}

class _BreatheState extends State<Breathe> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: widget.period)..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = MnMotion.ease.transform(_c.value);
        final s = widget.min + (widget.max - widget.min) * t;
        return Opacity(
          opacity: widget.fade ? 0.9 + 0.1 * t : 1,
          child: Transform.scale(scale: s, child: child),
        );
      },
      child: widget.child,
    );
  }
}

/// Expanding, fading ring (`ripple`).
class Ripple extends StatefulWidget {
  const Ripple({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  State<Ripple> createState() => _RippleState();
}

class _RippleState extends State<Ripple> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = MnMotion.easeOut.transform(_c.value);
        return Transform.scale(
          scale: 0.4 + 2.0 * t,
          child: Opacity(
            opacity: 0.5 * (1 - t),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
            ),
          ),
        );
      },
    );
  }
}

/// Three bouncing dots (typing indicator).
class TypingDots extends StatefulWidget {
  const TypingDots({super.key, required this.color});
  final Color color;

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 3; i++)
            Builder(builder: (context) {
              final p = ((_c.value - i * 0.15) % 1.0);
              final k = p < 0.3 ? math.sin(p / 0.3 * math.pi) : 0.0;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 7,
                height: 7,
                transform: Matrix4.translationValues(0, -5 * k, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.4 + 0.6 * k),
                ),
              );
            }),
        ],
      ),
    );
  }
}

/// Animated success badge: rippling ring, pop-in disc and a drawn check.
class SuccessCheck extends StatefulWidget {
  const SuccessCheck({super.key, this.size = 96, required this.color, required this.ring});

  final double size;
  final Color color;
  final Color ring;

  @override
  State<SuccessCheck> createState() => _SuccessCheckState();
}

class _SuccessCheckState extends State<SuccessCheck> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ripple(color: widget.ring, size: widget.size),
          PopIn(
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
              child: AnimatedBuilder(
                animation: _c,
                builder: (context, _) => CustomPaint(
                  painter: _CheckPainter(Interval(.3, 1, curve: MnMotion.easeOut).transform(_c.value)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  _CheckPainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width * .48 / 24;
    canvas.translate(size.width * .26, size.height * .26);
    canvas.scale(s);
    final p = Path()
      ..moveTo(4, 12.5)
      ..lineTo(9.5, 18)
      ..lineTo(20, 6.5);
    final m = p.computeMetrics().first;
    canvas.drawPath(
      m.extractPath(0, m.length * t),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_CheckPainter old) => old.t != t;
}
