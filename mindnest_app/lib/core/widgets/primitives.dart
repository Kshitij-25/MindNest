import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/text.dart';
import '../theme/tokens.dart';
import 'icon.dart';

const _avaHues = [
  Color(0xFF7C9D6B),
  Color(0xFF6FA98C),
  Color(0xFFA6886B),
  Color(0xFF8B95B0),
  Color(0xFFB0848B),
  Color(0xFF6E9AA6),
];

Color avaHue(String name) {
  int h = 0;
  for (final ch in name.codeUnits) {
    h = ch + ((h << 5) - h);
  }
  return _avaHues[h.abs() % _avaHues.length];
}

String initials(String name) {
  final parts = name.split(' ').where((w) => w.isNotEmpty).take(2);
  return parts.map((w) => w[0]).join().toUpperCase();
}

/// Round avatar — initials, or a soft photo placeholder.
class Avatar extends StatelessWidget {
  const Avatar(
    this.name, {
    super.key,
    this.size = 48,
    this.photo = false,
    this.ring = false,
  });

  final String name;
  final double size;
  final bool photo;
  final bool ring;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final hue = avaHue(name);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: photo
            ? LinearGradient(
                begin: const Alignment(-0.7, -1),
                end: const Alignment(0.7, 1),
                colors: [hue, avaHue('${name}x')],
              )
            : null,
        color: photo ? null : hue,
        boxShadow: ring
            ? [
                BoxShadow(color: c.primaryRing, spreadRadius: 4.5),
                BoxShadow(color: c.surface, spreadRadius: 3),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: photo
          ? MnIcon(
              'user',
              size: size * 0.5,
              color: const Color(0xEBFFFFFF),
              stroke: 1.6,
            )
          : Text(
              initials(name),
              style: TextStyle(
                fontSize: size * 0.38,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1,
              ),
            ),
    );
  }
}

const _mouths = {
  1: 'M9 17c1-2 5-2 6 0',
  2: 'M9 16.2c1-1 5-1 6 0',
  3: 'M9 16h6',
  4: 'M9 15.5c1 1.4 5 1.4 6 0',
  5: 'M8.5 15c1.2 2.4 5.8 2.4 7 0',
};

/// One of five soft mood expressions (circle + eyes + mouth arc).
class MoodFace extends StatelessWidget {
  const MoodFace({
    super.key,
    this.level = 3,
    this.size = 56,
    this.color,
    this.soft = true,
  });

  final int level;
  final double size;
  final Color? color;
  final bool soft;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final mc = color ?? c.moodColor(level);
    final bg = soft ? mix(c.surface, mc, 0.26) : mc;
    final stroke = soft ? mc : const Color(0xF2FFFFFF);
    final eyeY = level >= 4 ? 10.5 : 11.0;
    final s = svgRgba(stroke);
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" width="${size * 0.62}" height="${size * 0.62}" '
        'viewBox="0 0 24 24" fill="none" stroke="$s" stroke-width="1.9" stroke-linecap="round">'
        '<circle cx="9" cy="$eyeY" r="0.6" fill="$s" stroke="none"/>'
        '<circle cx="15" cy="$eyeY" r="0.6" fill="$s" stroke="none"/>'
        '<path d="${_mouths[level]}"/></svg>';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.string(svg, width: size * 0.62, height: size * 0.62),
    );
  }
}

/// A single filled star plus the numeric rating (matches the design's `Stars`).
class Stars extends StatelessWidget {
  const Stars(this.value, {super.key, this.size = 13});
  final double value;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MnIcon(
          'star',
          size: size,
          color: c.moss500,
          fill: c.moss500,
          stroke: 0,
        ),
        const SizedBox(width: 3),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size + 1,
            color: c.ink,
          ),
        ),
      ],
    );
  }
}

/// Verified-professional shield.
class Verified extends StatelessWidget {
  const Verified({super.key, this.size = 16});
  final double size;
  @override
  Widget build(BuildContext context) =>
      MnIcon('shield', size: size, color: context.c.primary);
}

/// Striped, labelled photo placeholder (avatars-in-lists / portrait slots).
class PhotoPlaceholder extends StatelessWidget {
  const PhotoPlaceholder(this.name, {super.key, this.label});
  final String name;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final hue = avaHue(name);
    return CustomPaint(
      painter: _StripePainter(hue),
      child: Center(
        child: LayoutBuilder(
          builder: (context, cons) {
            final d = cons.biggest.shortestSide * 0.38;
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: d,
                  height: d,
                  decoration: BoxDecoration(
                    color: hue.withValues(alpha: 0.33),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: MnIcon('user', size: 26, color: hue, stroke: 1.6),
                ),
                if (label != null)
                  Positioned(
                    bottom: 8,
                    child: Text(
                      label!,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9.5,
                        color: hue.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter(this.hue);
  final Color hue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = hue.withValues(alpha: 0.13),
    );
    final paint = Paint()..color = hue.withValues(alpha: 0.20);
    // 135deg diagonal stripes, 16px period.
    const period = 16.0;
    final diag = size.width + size.height;
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    for (double d = -size.height; d < diag; d += period) {
      final path = Path()
        ..moveTo(d, 0)
        ..lineTo(d + size.height, size.height)
        ..lineTo(d + size.height + period / 2, size.height)
        ..lineTo(d + period / 2, 0)
        ..close();
      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_StripePainter old) => old.hue != hue;
}

/// 7-day mood bar strip used on Home and Profile.
class MoodStrip extends StatelessWidget {
  const MoodStrip(this.data, {super.key});
  final List<({String day, int level})> data;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < data.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 8 + data[i].level * 9,
                    decoration: BoxDecoration(
                      color: c
                          .moodColor(data[i].level)
                          .withValues(alpha: i == data.length - 1 ? 1 : 0.85),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data[i].day[0],
                    style: MnText.cap.copyWith(
                      color: c.ink3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// MindNest leaf mark.
class Leaf extends StatelessWidget {
  const Leaf({super.key, this.size = 20, this.color = Colors.white});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final fill = svgRgba(color);
    final vein = color == Colors.white ? '#5C7C45' : '#ffffff';
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 24 24" fill="none">'
        '<path d="M5 19c0-7 5-13 14-14 1 9-3 15-10 15-1.5 0-2.7-.4-4-1Z" fill="$fill" opacity="0.95"/>'
        '<path d="M5 19C8 14 11 11 16 8.5" stroke="$vein" stroke-width="1.4" stroke-linecap="round" opacity="0.5"/></svg>';
    return SvgPicture.string(svg, width: size, height: size);
  }
}

/// App logo: rounded-square moss gradient with a leaf, optional gentle breathing.
class Logo extends StatefulWidget {
  const Logo({super.key, this.size = 64, this.breathe = true});
  final double size;
  final bool breathe;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    // Create eagerly while the element is active — a lazy `late` controller
    // first touched in dispose() would look up TickerMode on a deactivated
    // element and assert. Only animate when breathing.
    _ctl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    if (widget.breathe) _ctl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final box = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.size * 0.32),
        gradient: LinearGradient(
          begin: const Alignment(-0.6, -1),
          end: const Alignment(0.6, 1),
          colors: [c.moss400, c.primary],
        ),
        boxShadow: [
          BoxShadow(
            color: c.primaryRing,
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Leaf(size: widget.size * 0.5),
    );
    if (!widget.breathe) return box;
    return ScaleTransition(
      scale: Tween(
        begin: 0.96,
        end: 1.06,
      ).animate(CurvedAnimation(parent: _ctl, curve: Curves.easeInOut)),
      child: box,
    );
  }
}
