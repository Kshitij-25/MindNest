import 'package:flutter/material.dart';

import '../adaptive/adaptive.dart';
import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'mn_icon.dart';
import 'pressable.dart';

enum MnButtonVariant { primary, secondary, tonal, ghost, outline, danger }

enum MnButtonSize { regular, small }

/// The MindNest button (`.btn` + variants).
class MnButton extends StatelessWidget {
  const MnButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MnButtonVariant.primary,
    this.size = MnButtonSize.regular,
    this.icon,
    this.leading,
    this.trailingIcon,
    this.expand = true,
    this.pill = false,
    this.loading = false,
  });

  const MnButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = MnButtonSize.regular,
    this.icon,
    this.leading,
    this.trailingIcon,
    this.expand = true,
    this.pill = false,
    this.loading = false,
  }) : variant = MnButtonVariant.secondary;

  const MnButton.tonal({
    super.key,
    required this.label,
    this.onPressed,
    this.size = MnButtonSize.regular,
    this.icon,
    this.leading,
    this.trailingIcon,
    this.expand = true,
    this.pill = false,
    this.loading = false,
  }) : variant = MnButtonVariant.tonal;

  const MnButton.outline({
    super.key,
    required this.label,
    this.onPressed,
    this.size = MnButtonSize.regular,
    this.icon,
    this.leading,
    this.trailingIcon,
    this.expand = true,
    this.pill = false,
    this.loading = false,
  }) : variant = MnButtonVariant.outline;

  const MnButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.size = MnButtonSize.regular,
    this.icon,
    this.leading,
    this.trailingIcon,
    this.expand = true,
    this.pill = false,
    this.loading = false,
  }) : variant = MnButtonVariant.ghost;

  final String label;
  final VoidCallback? onPressed;
  final MnButtonVariant variant;
  final MnButtonSize size;
  final MnIconData? icon;
  final Widget? leading;
  final MnIconData? trailingIcon;
  final bool expand;
  final bool pill;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final small = size == MnButtonSize.small;
    final disabled = onPressed == null || loading;

    final (Color bg, Color fg, List<BoxShadow> shadow, Border? border) = switch (variant) {
      MnButtonVariant.primary => (
          c.primary,
          c.onPrimary,
          [BoxShadow(color: c.primaryRing, blurRadius: 16, offset: const Offset(0, 6))],
          null,
        ),
      MnButtonVariant.secondary => (c.fill, c.ink, const <BoxShadow>[], null),
      MnButtonVariant.tonal => (c.primaryTint, c.primary, const <BoxShadow>[], null),
      MnButtonVariant.ghost => (Colors.transparent, c.primary, const <BoxShadow>[], null),
      MnButtonVariant.outline => (
          Colors.transparent,
          c.ink,
          const <BoxShadow>[],
          Border.all(color: c.hairline2, width: 1.5),
        ),
      MnButtonVariant.danger => (c.red.withValues(alpha: .12), c.red, const <BoxShadow>[], null),
    };

    final radius = pill ? MnRadii.pill : (small ? MnRadii.xs : MnRadii.sm);
    final textStyle = TextStyle(
      color: fg,
      fontSize: small ? 15 : 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.17,
    );

    Widget content = loading
        ? AdaptiveLoader(size: small ? 18 : 22, color: fg)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 9)],
              if (icon != null) ...[MnIcon(icon!, size: small ? 17 : 20, color: fg, stroke: 2.2), const SizedBox(width: 8)],
              Flexible(child: Text(label, style: textStyle, overflow: TextOverflow.ellipsis, maxLines: 1)),
              if (trailingIcon != null) ...[const SizedBox(width: 8), MnIcon(trailingIcon!, size: small ? 17 : 20, color: fg, stroke: 2.2)],
            ],
          );

    final button = AnimatedOpacity(
      opacity: disabled && !loading ? 0.4 : 1,
      duration: MnMotion.base,
      child: AnimatedContainer(
        duration: MnMotion.base,
        curve: MnMotion.ease,
        constraints: BoxConstraints(minHeight: small ? 40 : 52),
        padding: EdgeInsets.symmetric(horizontal: small ? 16 : 22),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: disabled ? const [] : shadow,
          border: border,
        ),
        alignment: Alignment.center,
        child: content,
      ),
    );

    return Semantics(
      button: true,
      enabled: !disabled,
      label: label,
      excludeSemantics: true,
      child: Pressable(
        onTap: disabled ? null : onPressed,
        child: expand ? SizedBox(width: double.infinity, child: button) : button,
      ),
    );
  }
}

/// Plain text link button (`linkBtn`).
class MnLinkButton extends StatelessWidget {
  const MnLinkButton({super.key, required this.label, this.onPressed, this.color, this.fontSize = 15});

  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onPressed,
      scale: 0.96,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        child: Text(
          label,
          style: TextStyle(
            color: color ?? context.colors.primary,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

/// Circular icon button used in nav headers (`.nav-btn`) and tablet topbars.
class MnIconButton extends StatelessWidget {
  const MnIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.iconSize = 22,
    this.stroke = 2.2,
    this.background,
    this.color,
    this.square = false,
    this.badge = false,
    required this.tooltip,
  });

  final MnIconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final double stroke;
  final Color? background;
  final Color? color;
  final bool square;
  final bool badge;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // Ensure a ≥44pt touch target even for visually small buttons.
    return Tooltip(
      message: tooltip,
      child: Pressable(
        onTap: onPressed,
        scale: 0.92,
        semanticLabel: tooltip,
        child: SizedBox(
          width: size < 44 ? 44 : size,
          height: size < 44 ? 44 : size,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: background ?? c.fill,
                    borderRadius: BorderRadius.circular(square ? 12 : size / 2),
                  ),
                  alignment: Alignment.center,
                  child: MnIcon(icon, size: iconSize, stroke: stroke, color: color ?? c.ink),
                ),
                if (badge)
                  Positioned(
                    top: 8,
                    right: 9,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: c.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: background ?? c.bg, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
