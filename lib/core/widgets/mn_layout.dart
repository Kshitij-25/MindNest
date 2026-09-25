import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../adaptive/adaptive.dart';
import '../theme/app_colors.dart';
import '../utils/context_x.dart';
import 'mn_button.dart';
import 'mn_icon.dart';

/// Top navigation header (`NavHeader`): back button · centred title · action.
class MnNavHeader extends StatelessWidget implements PreferredSizeWidget {
  const MnNavHeader({
    super.key,
    this.title,
    this.showBack = true,
    this.onBack,
    this.trailing,
    this.transparent = false,
    this.leading,
  });

  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool transparent;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final canPop = context.router.canPop() || onBack != null;
    return Container(
      color: transparent ? Colors.transparent : c.bg,
      padding: EdgeInsets.fromLTRB(8, MediaQuery.paddingOf(context).top + 6, 8, 6),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (showBack && canPop)
              MnIconButton(
                icon: context.isIOS ? MnIcons.back : MnIcons.arrowR,
                tooltip: 'Back',
                onPressed: onBack ?? () => context.router.maybePop(),
                // Android uses a left arrow; iOS a chevron.
                color: c.ink,
              ).flipIf(!context.isIOS)
            else
              const SizedBox(width: 44),
            Expanded(
              child: title == null
                  ? const SizedBox()
                  : Semantics(
                      header: true,
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.headline.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
            ),
            trailing ?? const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}

extension _Flip on Widget {
  Widget flipIf(bool flip) => flip ? Transform.flip(flipX: true, child: this) : this;
}

/// Standard page: background, optional header, scrollable body with gutters,
/// optional pinned bottom bar. Content is width-capped on tablets.
class MnPage extends StatelessWidget {
  const MnPage({
    super.key,
    this.header,
    required this.body,
    this.bottom,
    this.scroll = true,
    this.padding,
    this.maxWidth = 640,
    this.background,
    this.controller,
  });

  final PreferredSizeWidget? header;
  final Widget body;
  final Widget? bottom;
  final bool scroll;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final Color? background;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // Bottom inset covers the home indicator and a floating tab bar
    // (Scaffold.extendBody feeds the bar height through MediaQuery).
    final inset = bottom == null ? MediaQuery.paddingOf(context).bottom : 0.0;
    final base = padding ?? EdgeInsets.fromLTRB(context.gutter, 8, context.gutter, 40);
    final pad = base.add(EdgeInsets.only(bottom: inset));
    Widget content = scroll
        ? SingleChildScrollView(
            controller: controller,
            physics: Adaptive.scrollPhysics(context),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: pad,
            child: _cap(body),
          )
        : Padding(padding: pad, child: _cap(body));

    return Scaffold(
      backgroundColor: background ?? c.bg,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          ?header,
          if (header == null) SizedBox(height: MediaQuery.paddingOf(context).top),
          Expanded(child: content),
          if (bottom != null)
            Container(
              color: background ?? c.bg,
              padding: EdgeInsets.fromLTRB(context.gutter, 12, context.gutter, MediaQuery.paddingOf(context).bottom + 16),
              child: _cap(bottom!),
            ),
        ],
      ),
    );
  }

  Widget _cap(Widget w) => maxWidth == null
      ? w
      : Center(
          child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: w),
        );
}

/// Section title with optional trailing action (`SectionHead` / `TSection`).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.subtitle, this.action, this.onAction, this.padding});

  final String title;
  final String? subtitle;
  final String? action;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(2, 0, 2, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(header: true, child: Text(title, style: context.text.title3)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: context.text.sub.copyWith(color: c.ink3)),
                ],
              ],
            ),
          ),
          if (action != null) MnLinkButton(label: action!, onPressed: onAction),
        ],
      ),
    );
  }
}

/// Large page title used at the top of tab screens.
class LargeTitle extends StatelessWidget {
  const LargeTitle({super.key, required this.title, this.eyebrow, this.trailing, this.serif = false});

  final String title;
  final String? eyebrow;
  final Widget? trailing;
  final bool serif;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null)
                Text(eyebrow!, style: context.text.sub.copyWith(color: c.ink3, fontWeight: FontWeight.w600)),
              Semantics(
                header: true,
                child: Text(title, style: serif ? context.text.display : context.text.title1),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// MindNest leaf mark.
class LeafMark extends StatelessWidget {
  const LeafMark({super.key, this.size = 20, this.color = Colors.white});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _LeafPainter(color));
}

class _LeafPainter extends CustomPainter {
  _LeafPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24);
    final leaf = Path()
      ..moveTo(5, 19)
      ..cubicTo(5, 12, 10, 6, 19, 5)
      ..cubicTo(20, 14, 16, 20, 9, 20)
      ..cubicTo(7.5, 20, 6.3, 19.6, 5, 19)
      ..close();
    canvas.drawPath(leaf, Paint()..color = color.withValues(alpha: .95));
    final vein = Path()
      ..moveTo(5, 19)
      ..cubicTo(8, 14, 11, 11, 16, 8.5);
    canvas.drawPath(
      vein,
      Paint()
        ..color = (color == Colors.white ? const Color(0xFF5C7C45) : Colors.white).withValues(alpha: .5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_LeafPainter old) => old.color != color;
}

/// App logo: gradient squircle with the leaf (`Logo`).
class MnLogo extends StatelessWidget {
  const MnLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: 'MindNest',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * .32),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [MnColors.moss400, c.primary],
          ),
          boxShadow: [BoxShadow(color: c.primaryRing, blurRadius: 32, offset: const Offset(0, 12))],
        ),
        alignment: Alignment.center,
        child: LeafMark(size: size * .5),
      ),
    );
  }
}

/// Soft gradient imagery placeholder (`TImage` / `PhotoPlaceholder`).
class MnImagePlaceholder extends StatelessWidget {
  const MnImagePlaceholder({super.key, this.seed = 0, this.height = 130, this.radius = 16, this.label});

  final int seed;
  final double height;
  final double radius;
  final String? label;

  static const _hues = [
    [Color(0xFFA8C49A), Color(0xFF7C9D6B)],
    [Color(0xFF9BBCC4), Color(0xFF6E9AA6)],
    [Color(0xFFC9B79A), Color(0xFFA6886B)],
    [Color(0xFFB6A9C9), Color(0xFF8B8FB0)],
    [Color(0xFFC4A0A6), Color(0xFFB0848B)],
  ];

  @override
  Widget build(BuildContext context) {
    final h = _hues[seed % _hues.length];
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: h),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: RadialGradient(
                  center: const Alignment(.6, -.8),
                  radius: 1.1,
                  colors: [Colors.white.withValues(alpha: .28), Colors.transparent],
                  stops: const [0, .6],
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 10,
            child: Opacity(opacity: .6, child: MnIcon(MnIcons.image, size: 18, color: Colors.white, stroke: 1.8)),
          ),
          if (label != null)
            Positioned(
              left: 14,
              bottom: 12,
              child: Text(label!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
        ],
      ),
    );
  }
}

/// Friendly empty state with icon, title, message and optional CTA.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final MnIconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(color: c.primaryTint, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: MnIcon(icon, size: 38, color: c.primary, stroke: 1.7),
          ),
          const SizedBox(height: 22),
          Text(title, style: context.text.title3, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(message, style: context.text.callout.copyWith(color: c.ink2), textAlign: TextAlign.center),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 24),
            MnButton(label: actionLabel!, onPressed: onAction, expand: false, pill: true),
          ],
        ],
      ),
    );
  }
}

/// Centred error state with retry.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: EmptyState(
          icon: MnIcons.info,
          title: 'Something went wrong',
          message: message,
          actionLabel: onRetry == null ? null : 'Try again',
          onAction: onRetry,
        ),
      );
}

/// Centred loader.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(padding: EdgeInsets.all(40), child: AdaptiveLoader()),
      );
}

/// Grouped list row (`.row`) used in settings/profile menus.
class MnListRow extends StatelessWidget {
  const MnListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron = true,
    this.destructive = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap == null
            ? null
            : () {
                Adaptive.tap(context);
                onTap!();
              },
        splashFactory: NoSplash.splashFactory,
        highlightColor: c.fill,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 14)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.text.body.copyWith(
                          fontWeight: FontWeight.w500,
                          color: destructive ? c.red : c.ink,
                        ),
                      ),
                      if (subtitle != null)
                        Text(subtitle!, style: context.text.foot.copyWith(color: c.ink3)),
                    ],
                  ),
                ),
                ?trailing,
                if (showChevron && onTap != null) ...[
                  const SizedBox(width: 6),
                  MnIcon(MnIcons.chevR, size: 18, color: c.ink4),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A card containing a list of [MnListRow]s separated by hairlines.
class MnGroup extends StatelessWidget {
  const MnGroup({super.key, required this.children, this.title});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 8),
            child: Text(title!.toUpperCase(), style: context.text.cap.copyWith(color: c.ink3)),
          ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Container(margin: const EdgeInsets.only(left: 64), height: 0.5, color: c.hairline),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
