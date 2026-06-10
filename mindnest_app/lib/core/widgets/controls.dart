import 'package:flutter/material.dart';

import '../theme/text.dart';
import '../theme/tokens.dart';
import 'common.dart';
import 'icon.dart';

enum MnVariant { primary, secondary, tonal, ghost, outline }

/// Pill/rounded button matching `.btn` and its variants.
class MnButton extends StatefulWidget {
  const MnButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.variant = MnVariant.primary,
    this.small = false,
    this.pill = false,
    this.expand = true,
    this.leading,
    this.foreground,
    this.background,
  });

  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final MnVariant variant;
  final bool small;
  final bool pill;
  final bool expand;
  final Widget? leading;
  final Color? foreground;
  final Color? background;

  @override
  State<MnButton> createState() => _MnButtonState();
}

class _MnButtonState extends State<MnButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final disabled = widget.onPressed == null;

    Color bg;
    Color fg;
    List<BoxShadow>? shadow;
    BoxBorder? border;
    switch (widget.variant) {
      case MnVariant.primary:
        bg = _down ? c.primaryPress : c.primary;
        fg = c.onPrimary;
        shadow = c.primaryGlow();
        break;
      case MnVariant.secondary:
        bg = _down ? c.fill2 : c.fill;
        fg = c.ink;
        break;
      case MnVariant.tonal:
        bg = c.primaryTint;
        fg = c.primary;
        break;
      case MnVariant.ghost:
        bg = Colors.transparent;
        fg = c.primary;
        break;
      case MnVariant.outline:
        bg = Colors.transparent;
        fg = c.ink;
        border = Border.all(color: c.hairline2, width: 1.5);
        break;
    }
    if (widget.background != null) bg = widget.background!;
    if (widget.foreground != null) fg = widget.foreground!;

    final content = DefaultTextStyle(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: widget.small ? 15 : 17,
        letterSpacing: -0.15,
        color: fg,
        height: 1,
      ),
      child: IconTheme(
        data: IconThemeData(color: fg),
        child: Row(
          mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 9),
            ],
            if (widget.label != null)
              Flexible(
                child: Text(widget.label!, overflow: TextOverflow.ellipsis),
              ),
            if (widget.child != null) widget.child!,
          ],
        ),
      ),
    );

    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: disabled ? null : (_) => setState(() => _down = true),
        onTapUp: disabled ? null : (_) => setState(() => _down = false),
        onTapCancel: disabled ? null : () => setState(() => _down = false),
        child: AnimatedScale(
          scale: _down ? 0.97 : 1,
          duration: const Duration(milliseconds: 130),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            constraints: BoxConstraints(minHeight: widget.small ? 40 : 52),
            padding: EdgeInsets.symmetric(horizontal: widget.small ? 16 : 22),
            decoration: BoxDecoration(
              color: bg,
              border: border,
              borderRadius: BorderRadius.circular(
                widget.pill
                    ? MnRadius.pill
                    : (widget.small ? MnRadius.xs : MnRadius.sm),
              ),
              boxShadow: disabled ? null : shadow,
            ),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}

enum MnCardKind { card, flat, inset }

/// Surface container — `.card`, `.card-flat`, `.card-inset`.
class MnCard extends StatelessWidget {
  const MnCard({
    super.key,
    required this.child,
    this.kind = MnCardKind.card,
    this.padding,
    this.onTap,
    this.color,
    this.radius,
    this.clip = false,
    this.pressable = true,
  });

  final Widget child;
  final MnCardKind kind;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final double? radius;
  final bool clip;
  final bool pressable;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final r = radius ?? (kind == MnCardKind.inset ? MnRadius.md : MnRadius.lg);
    final bg = color ?? (kind == MnCardKind.inset ? c.surface3 : c.surface);
    final shadow = switch (kind) {
      MnCardKind.card => c.shMd,
      MnCardKind.flat => c.shSm,
      MnCardKind.inset => null,
    };
    final Widget box = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(r),
        boxShadow: shadow,
      ),
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      child: child,
    );
    if (onTap != null && pressable) return Pressable(onTap: onTap, child: box);
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: box,
      );
    }
    return box;
  }
}

/// Pill chip / filter (`.chip`, `.chip.active`, `.chip.outline`).
class Chip2 extends StatelessWidget {
  const Chip2(
    this.label, {
    super.key,
    this.active = false,
    this.outline = false,
    this.onTap,
    this.leading,
    this.height = 36,
  });

  final String label;
  final bool active;
  final bool outline;
  final VoidCallback? onTap;
  final Widget? leading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final fg = active ? c.onPrimary : c.ink2;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: active ? c.primary : (outline ? Colors.transparent : c.fill),
          borderRadius: BorderRadius.circular(MnRadius.pill),
          border: Border.all(
            color: outline && !active ? c.hairline2 : Colors.transparent,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 6)],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fg,
                letterSpacing: -0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum BadgeKind { verify, pending, accept, reject }

class Badge2 extends StatelessWidget {
  const Badge2(
    this.label, {
    super.key,
    this.kind = BadgeKind.verify,
    this.leading,
    this.height = 22,
    this.fontSize = 11.5,
  });
  final String label;
  final BadgeKind kind;
  final Widget? leading;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final (Color bg, Color fg) = switch (kind) {
      BadgeKind.verify => (c.primaryTint, c.primary),
      BadgeKind.pending => (c.amber.withValues(alpha: 0.16), c.amber),
      BadgeKind.accept => (c.green.withValues(alpha: 0.16), c.green),
      BadgeKind.reject => (c.red.withValues(alpha: 0.16), c.red),
    };
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MnRadius.pill),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 4)],
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: fg,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Colored topic tag with a leading dot (`TopicTag`).
class TopicTag extends StatelessWidget {
  const TopicTag(
    this.topic, {
    super.key,
    this.sm = false,
    this.active = false,
    this.onTap,
  });
  final String topic;
  final bool sm;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = c.topicColor(topic);
    final dot = sm ? 5.0 : 6.0;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: sm ? 24 : 32,
        padding: EdgeInsets.symmetric(horizontal: sm ? 9 : 13),
        decoration: BoxDecoration(
          color: active ? col : tint(col, 0.14),
          borderRadius: BorderRadius.circular(MnRadius.pill),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: dot,
              height: dot,
              decoration: BoxDecoration(
                color: active ? Colors.white : col,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: sm ? 5 : 6),
            Text(
              topic,
              style: TextStyle(
                fontSize: sm ? 12 : 13.5,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.13,
                color: active ? Colors.white : col,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// iOS-style toggle (51×31).
class MnToggle extends StatelessWidget {
  const MnToggle({super.key, required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        width: 51,
        height: 31,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? c.primary : c.hairline2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutBack,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 27,
            height: 27,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Segmented control with a sliding thumb.
class Segmented extends StatelessWidget {
  const Segmented({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
  });
  final List<String> options;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final idx = options.indexOf(value).clamp(0, options.length - 1);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: c.fill,
        borderRadius: BorderRadius.circular(MnRadius.xs),
      ),
      child: LayoutBuilder(
        builder: (context, cons) {
          final w = (cons.maxWidth - 6) / options.length;
          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutBack,
                alignment: Alignment(
                  options.length == 1
                      ? 0
                      : (idx / (options.length - 1)) * 2 - 1,
                  0,
                ),
                child: Container(
                  width: w,
                  height: 30,
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: c.shSm,
                  ),
                ),
              ),
              Row(
                children: [
                  for (final o in options)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onChanged(o),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            o,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: o == value ? c.ink : c.ink2,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Text input with leading icon and optional trailing widget (`.field`).
class MnField extends StatefulWidget {
  const MnField({
    super.key,
    this.icon,
    this.hint,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.trailing,
    this.onChanged,
    this.minLines,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final String? icon;
  final String? hint;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int? maxLines;
  final bool autofocus;

  @override
  State<MnField> createState() => _MnFieldState();
}

class _MnFieldState extends State<MnField> {
  final _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final multiline = (widget.maxLines ?? 1) > 1;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(MnRadius.sm),
        border: Border.all(
          color: _focused ? c.primary : c.hairline,
          width: 1.5,
        ),
        boxShadow: _focused
            ? [BoxShadow(color: c.primaryRing, blurRadius: 0, spreadRadius: 4)]
            : null,
      ),
      constraints: const BoxConstraints(minHeight: 54),
      padding: EdgeInsets.fromLTRB(
        widget.icon != null ? 14 : 16,
        multiline ? 12 : 0,
        widget.trailing != null ? 8 : 16,
        0,
      ),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            Padding(
              padding: EdgeInsets.only(top: multiline ? 3 : 0),
              child: MnIcon(widget.icon!, size: 20, color: c.ink3, stroke: 1.9),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              obscureText: widget.obscure,
              keyboardType: widget.keyboardType,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              cursorColor: c.primary,
              style: MnText.body.copyWith(color: c.ink),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: multiline ? 0 : 16,
                ),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: MnText.body.copyWith(color: c.ink4),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

/// Draggable value slider (`Slider` in the prototype).
class MnSlider extends StatelessWidget {
  const MnSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 10,
    this.color,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = color ?? c.primary;
    final pct = (value - min) / (max - min);
    return LayoutBuilder(
      builder: (context, cons) {
        final w = cons.maxWidth;
        void setFromDx(double dx) {
          final p = (dx / w).clamp(0.0, 1.0);
          final v = (min + p * (max - min)).round();
          if (v != value) onChanged(v);
        }

        return GestureDetector(
          onTapDown: (d) => setFromDx(d.localPosition.dx),
          onPanUpdate: (d) => setFromDx(d.localPosition.dx),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 44,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: c.fill2,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: pct.clamp(0.0, 1.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: col,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(pct.clamp(0.0, 1.0) * 2 - 1, 0),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: c.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0x2E000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                        BoxShadow(color: c.hairline, spreadRadius: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
