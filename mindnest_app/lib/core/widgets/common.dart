import 'package:flutter/material.dart';

import '../theme/text.dart';
import '../theme/tokens.dart';

/// Top safe-area inset (replaces the prototype's fixed `SAFE_TOP`).
double safeTop(BuildContext context) => MediaQuery.of(context).padding.top;

/// Bottom safe-area inset (replaces `env(safe-area-inset-bottom)`).
double safeBottom(BuildContext context) =>
    MediaQuery.of(context).padding.bottom;

/// Screen container: paints the calm background and seeds the default text
/// style (system font, ink color) so unstyled text inherits the right color.
class MnScaffold extends StatelessWidget {
  const MnScaffold({
    super.key,
    required this.child,
    this.background,
    this.decoration,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget child;
  final Color? background;
  final Decoration? decoration;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Scaffold(
      backgroundColor: background ?? c.bg,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: DefaultTextStyle(
        style: MnText.body.copyWith(color: c.ink),
        child: decoration != null
            ? DecoratedBox(
                decoration: decoration!,
                child: SizedBox.expand(child: child),
              )
            : child,
      ),
    );
  }
}

/// Scales its child down slightly while pressed — the design's `.pressable`.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.97,
    this.behavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final HitTestBehavior behavior;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;
  void _set(bool v) {
    if (widget.onTap == null) return;
    if (_down != v) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// 0.5px hairline divider.
class Hairline extends StatelessWidget {
  const Hairline({super.key, this.margin = EdgeInsets.zero});
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) =>
      Container(height: 0.5, margin: margin, color: context.c.hairline);
}

/// Hides the scrollbar and removes the over-scroll glow, matching the
/// borderless feel of the design.
class NoGlow extends StatelessWidget {
  const NoGlow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ScrollConfiguration(behavior: const _NoGlowBehavior(), child: child);
}

class _NoGlowBehavior extends ScrollBehavior {
  const _NoGlowBehavior();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}

/// Entry animation: fade + slide up (the design's `.anim-up`).
class FadeUp extends StatefulWidget {
  const FadeUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 14,
  });
  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<FadeUp> createState() => _FadeUpState();
}

class _FadeUpState extends State<FadeUp> with SingleTickerProviderStateMixin {
  late final AnimationController _ctl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  );
  late final Animation<double> _a = CurvedAnimation(
    parent: _ctl,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _ctl.forward();
    });
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _a,
    builder: (_, child) => Opacity(
      opacity: _a.value,
      child: Transform.translate(
        offset: Offset(0, (1 - _a.value) * widget.offset),
        child: child,
      ),
    ),
    child: widget.child,
  );
}
