import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/icon.dart';

/// MVP-1 wellness components — the pieces in the design's `components.jsx`
/// that the complete app hadn't needed yet (`RadialScore`, `EmotionBar`,
/// `Spark`, `WeekDots`, `AnalysisStatus`, `TrendPill`, `Confidence`,
/// `IconTile`). They reuse the shared `MnColors` / `MnText` / `MnIcon`.

/// Radial 0–100 score ring with a centered label.
class RadialScore extends StatelessWidget {
  const RadialScore({
    super.key,
    this.value = 78,
    this.size = 132,
    this.stroke = 11,
    this.color,
    this.track,
    this.label,
    this.sub,
  });

  final double value;
  final double size;
  final double stroke;
  final Color? color;
  final Color? track;
  final String? label;
  final String? sub;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = color ?? c.primary;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              value: value.clamp(0, 100) / 100,
              stroke: stroke,
              color: col,
              track: track ?? c.fill2,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label ?? value.round().toString(),
                style: TextStyle(
                  fontSize: size * 0.27,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -size * 0.27 * 0.02,
                  height: 1,
                  color: c.ink,
                ),
              ),
              if (sub != null) ...[
                const SizedBox(height: 4),
                Text(
                  sub!,
                  style: MnText.cap.copyWith(
                    color: c.ink3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.stroke,
    required this.color,
    required this.track,
  });

  final double value;
  final double stroke;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final r = (size.width - stroke) / 2;
    final center = size.center(Offset.zero);
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = track;
    canvas.drawCircle(center, r, trackPaint);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value ||
      old.color != color ||
      old.track != track ||
      old.stroke != stroke;
}

/// Labelled horizontal emotion meter with optional trend delta + description.
class EmotionBar extends StatelessWidget {
  const EmotionBar({
    super.key,
    required this.label,
    required this.value,
    this.color,
    this.trend,
    this.desc,
  });

  final String label;
  final int value;
  final Color? color;
  final int? trend;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = color ?? c.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: MnText.callout.copyWith(
                    fontWeight: FontWeight.w600,
                    color: c.ink2,
                  ),
                ),
              ),
              if (trend != null) ...[
                Text(
                  '${trend! > 0 ? '+' : ''}$trend',
                  style: MnText.cap.copyWith(
                    fontWeight: FontWeight.w700,
                    color: trend! < 0
                        ? c.green
                        : trend! > 0
                        ? c.clay
                        : c.ink3,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              SizedBox(
                width: 30,
                child: Text(
                  '$value',
                  textAlign: TextAlign.right,
                  style: MnText.foot.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Stack(
              children: [
                Container(height: 8, color: c.fill2),
                FractionallySizedBox(
                  widthFactor: (value / 100).clamp(0, 1),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: col,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (desc != null) ...[
            const SizedBox(height: 6),
            Text(desc!, style: MnText.cap.copyWith(color: c.ink3)),
          ],
        ],
      ),
    );
  }
}

/// Filled sparkline with an end-point marker.
class Spark extends StatelessWidget {
  const Spark({
    super.key,
    required this.data,
    this.color,
    this.height = 36,
    this.fill = true,
  });

  final List<num> data;
  final Color? color;
  final double height;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    final col = color ?? context.c.primary;
    final surface = context.c.surface;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _SparkPainter(
          data: data.map((e) => e.toDouble()).toList(),
          color: col,
          fill: fill,
          surface: surface,
        ),
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter({
    required this.data,
    required this.color,
    required this.fill,
    required this.surface,
  });

  final List<double> data;
  final Color color;
  final bool fill;
  final Color surface;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;
    final maxV = data.reduce(math.max);
    final minV = data.reduce(math.min);
    final span = (maxV - minV) == 0 ? 1 : (maxV - minV);
    const pad = 3.0;
    Offset pt(int i) => Offset(
      pad + (i / (data.length - 1)) * (size.width - pad * 2),
      pad + (1 - (data[i] - minV) / span) * (size.height - pad * 2),
    );
    final path = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (var i = 1; i < data.length; i++) {
      path.lineTo(pt(i).dx, pt(i).dy);
    }
    if (fill) {
      final area = Path.from(path)
        ..lineTo(size.width - pad, size.height - pad)
        ..lineTo(pad, size.height - pad)
        ..close();
      final grad = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
      );
      canvas.drawPath(
        area,
        Paint()..shader = grad.createShader(Offset.zero & size),
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = color,
    );
    final end = pt(data.length - 1);
    canvas.drawCircle(end, 3, Paint()..color = surface);
    canvas.drawCircle(
      end,
      3,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(_SparkPainter old) =>
      old.data != data || old.color != color;
}

/// 7-day completion dots with weekday labels.
class WeekDots extends StatelessWidget {
  const WeekDots({
    super.key,
    required this.week,
    this.color,
    this.labels = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  });

  final List<bool> week;
  final Color? color;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = color ?? c.primary;
    return Row(
      children: [
        for (var i = 0; i < week.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 30),
                      decoration: BoxDecoration(
                        color: week[i] ? col : c.fill2,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      alignment: Alignment.center,
                      child: week[i]
                          ? const MnIcon(
                              'check',
                              size: 14,
                              color: Colors.white,
                              stroke: 2.6,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    labels[i % labels.length],
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

enum MnAnalysis { ready, pending, failed, disabled }

/// Status pill for the non-blocking journal analysis lifecycle.
class AnalysisStatus extends StatelessWidget {
  const AnalysisStatus({super.key, this.status = MnAnalysis.ready});
  final MnAnalysis status;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final (String icon, Color col, String txt) = switch (status) {
      MnAnalysis.ready => ('checkCircle', c.green, 'Analysis ready'),
      MnAnalysis.pending => ('clock', c.topic[2], 'Analysing…'),
      MnAnalysis.failed => ('info', c.clay, 'Analysis failed'),
      MnAnalysis.disabled => ('moon', c.ink3, 'Analysis off'),
    };
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MnIcon(icon, size: 14, color: col, stroke: 2),
          const SizedBox(width: 6),
          Text(
            txt,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: col,
            ),
          ),
        ],
      ),
    );
  }
}

enum TrendDir { up, down, flat }

/// Direction + value chip. [invert] flips which direction reads as "good"
/// (e.g. a falling stress score is positive).
class TrendPill extends StatelessWidget {
  const TrendPill({
    super.key,
    required this.label,
    this.dir = TrendDir.up,
    this.invert = false,
  });

  final String label;
  final TrendDir dir;
  final bool invert;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final good = invert ? dir == TrendDir.down : dir == TrendDir.up;
    final col = dir == TrendDir.flat
        ? c.ink3
        : good
        ? c.green
        : c.clay;
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.hairline2, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scaleY: dir == TrendDir.down ? -1 : 1,
            child: MnIcon(
              dir == TrendDir.flat ? 'arrowR' : 'trend',
              size: 14,
              color: col,
              stroke: 2.2,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: col,
            ),
          ),
        ],
      ),
    );
  }
}

/// "{value}% confidence" AI chip.
class Confidence extends StatelessWidget {
  const Confidence({super.key, this.value = 90, this.small = false});
  final int value;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      height: small ? 24 : 28,
      padding: EdgeInsets.symmetric(horizontal: small ? 9 : 11),
      decoration: BoxDecoration(
        color: c.primaryTint,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MnIcon('sparkle', size: small ? 12 : 14, color: c.primary, stroke: 2),
          const SizedBox(width: 6),
          Text(
            '$value% confidence',
            style: TextStyle(
              fontSize: small ? 12 : 13,
              fontWeight: FontWeight.w700,
              color: c.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded-square tinted icon tile.
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.color,
    this.size = 44,
    this.radius = 13,
  });

  final String icon;
  final Color? color;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final col = color ?? context.c.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: MnIcon(icon, size: size * 0.46, color: col, stroke: 1.9),
    );
  }
}
