import 'package:flutter/material.dart';

import '../theme/text.dart';
import '../theme/tokens.dart';
import 'common.dart';
import 'controls.dart';
import 'icon.dart';

/// Circular icon button — the design's `.nav-btn` (40×40 fill circle).
class NavBtn extends StatelessWidget {
  const NavBtn({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 40,
    this.iconSize = 22,
    this.stroke = 2.2,
    this.background,
    this.color,
    this.badge = false,
  });

  final String icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final double stroke;
  final Color? background;
  final Color? color;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Pressable(
      onTap: onTap,
      scale: 0.92,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background ?? c.fill,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            MnIcon(icon, size: iconSize, color: color ?? c.ink, stroke: stroke),
            if (badge)
              Positioned(
                top: -1,
                right: -1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: c.clay,
                    shape: BoxShape.circle,
                    border: Border.all(color: c.bg, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Navigation header (back / centered title / right action).
class NavHeader extends StatelessWidget {
  const NavHeader({
    super.key,
    this.title,
    this.onBack,
    this.right,
    this.transparent = false,
  });
  final String? title;
  final VoidCallback? onBack;
  final Widget? right;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      color: transparent ? Colors.transparent : c.bg,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      constraints: const BoxConstraints(minHeight: 52),
      child: Row(
        children: [
          if (onBack != null)
            NavBtn(icon: 'back', onTap: onBack)
          else
            const SizedBox(width: 40),
          Expanded(
            child: title == null
                ? const SizedBox()
                : Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: c.ink,
                      letterSpacing: -0.17,
                    ),
                  ),
          ),
          right ?? const SizedBox(width: 40),
        ],
      ),
    );
  }
}

/// Section header — title with an optional trailing text action.
class SectionHead extends StatelessWidget {
  const SectionHead(
    this.title, {
    super.key,
    this.action,
    this.onAction,
    this.padding,
  });
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(2, 0, 2, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: Text(title, style: MnText.title3.copyWith(color: c.ink)),
          ),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                action!,
                style: TextStyle(
                  color: c.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A small primary text link (the design's `linkBtn`).
class LinkBtn extends StatelessWidget {
  const LinkBtn(this.label, {super.key, this.onTap, this.fontSize = 15});
  final String label;
  final VoidCallback? onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Text(
      label,
      style: TextStyle(
        color: context.c.primary,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
    ),
  );
}

/// Centered empty-state with icon, copy and optional action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
    this.onAction,
  });

  final String icon;
  final String title;
  final String body;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return FadeUp(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(color: c.fill, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: MnIcon(icon, size: 40, color: c.ink4, stroke: 1.7),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              style: MnText.title3.copyWith(color: c.ink),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                body,
                textAlign: TextAlign.center,
                style: MnText.body.copyWith(color: c.ink2),
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: 22),
              MnButton(
                label: action,
                onPressed: onAction,
                variant: MnVariant.tonal,
                expand: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Animated success check (ripple ring + popped primary disc + checkmark).
class SuccessCheck extends StatefulWidget {
  const SuccessCheck({super.key, this.size = 96});
  final double size;
  @override
  State<SuccessCheck> createState() => _SuccessCheckState();
}

class _SuccessCheckState extends State<SuccessCheck>
    with TickerProviderStateMixin {
  late final AnimationController _ripple = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  @override
  void dispose() {
    _ripple.dispose();
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _ripple,
            builder: (_, _) {
              final t = _ripple.value;
              return Transform.scale(
                scale: 0.4 + t * 2.0,
                child: Opacity(
                  opacity: (0.5 * (1 - t)).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: c.primaryRing,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          ScaleTransition(
            scale: CurvedAnimation(parent: _pop, curve: Curves.easeOutBack),
            child: Container(
              decoration: BoxDecoration(
                color: c.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: MnIcon(
                'check',
                size: widget.size * 0.48,
                color: c.onPrimary,
                stroke: 2.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a MindNest bottom sheet (rounded top, grab handle, blurred scrim).
Future<T?> showMnSheet<T>(
  BuildContext context,
  WidgetBuilder builder, {
  double maxHeightFactor = 0.88,
}) {
  final c = context.c;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x660F120B),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * maxHeightFactor,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: c.shLg,
          ),
          child: DefaultTextStyle(
            style: MnText.body.copyWith(color: c.ink),
            child: SafeArea(top: false, child: builder(ctx)),
          ),
        ),
      ),
    ),
  );
}

/// The little grab handle for sheets.
class SheetGrab extends StatelessWidget {
  const SheetGrab({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: 40,
    height: 5,
    margin: const EdgeInsets.fromLTRB(0, 4, 0, 14),
    decoration: BoxDecoration(
      color: context.c.hairline2,
      borderRadius: BorderRadius.circular(999),
    ),
  );
}
