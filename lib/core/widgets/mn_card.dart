import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'pressable.dart';

enum MnCardStyle { raised, flat, inset, outlined }

/// Surface card (`.card`, `.card-flat`, `.card-inset`).
class MnCard extends StatelessWidget {
  const MnCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.style = MnCardStyle.raised,
    this.radius,
    this.color,
    this.onTap,
    this.gradient,
    this.clip = false,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final MnCardStyle style;
  final double? radius;
  final Color? color;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final bool clip;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = radius ?? (style == MnCardStyle.inset ? MnRadii.md : MnRadii.lg);
    final bg = color ?? (style == MnCardStyle.inset ? c.surface3 : c.surface);
    final shadow = switch (style) {
      MnCardStyle.raised => MnShadows.md(c),
      MnCardStyle.flat => MnShadows.sm(c),
      _ => const <BoxShadow>[],
    };
    final card = Container(
      padding: padding,
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      decoration: BoxDecoration(
        color: gradient == null ? bg : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(r),
        boxShadow: shadow,
        border: style == MnCardStyle.outlined ? Border.all(color: c.hairline, width: 1.5) : null,
      ),
      child: child,
    );
    if (onTap == null) return card;
    return Pressable(onTap: onTap, semanticLabel: semanticLabel, child: card);
  }
}

/// Coloured rounded square holding an icon (used all over the prototype).
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.child,
    this.size = 44,
    this.radius,
    this.color,
  });

  final Widget child;
  final double size;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? context.colors.primaryTint,
        borderRadius: BorderRadius.circular(radius ?? size * 0.3),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

/// 0.5px hairline divider.
class Hairline extends StatelessWidget {
  const Hairline({super.key, this.indent = 0, this.vertical = false});

  final double indent;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    if (vertical) return Container(width: 0.5, color: c.hairline);
    return Container(margin: EdgeInsets.only(left: indent), height: 0.5, color: c.hairline);
  }
}
