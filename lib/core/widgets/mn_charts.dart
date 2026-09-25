import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'mn_icon.dart';

class ChartBar {
  const ChartBar(this.label, this.value, {this.highlight = false, this.color});
  final String label;
  final double value;
  final bool highlight;
  final Color? color;
}

/// Animated bar chart (`BarChart`).
class MnBarChart extends StatelessWidget {
  const MnBarChart({super.key, required this.data, this.height = 150, this.color, this.max, this.valueLabel});

  final List<ChartBar> data;
  final double height;
  final Color? color;
  final double? max;
  final String Function(double)? valueLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = color ?? c.primary;
    final m = max ?? data.map((d) => d.value).fold<double>(0, math.max) * 1.15;
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < data.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(
              child: Semantics(
                label: '${data[i].label}: ${valueLabel?.call(data[i].value) ?? data[i].value.toStringAsFixed(0)}',
                child: Column(
                  children: [
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: m == 0 ? 0 : data[i].value / m),
                        duration: Duration(milliseconds: 600 + i * 50),
                        curve: MnMotion.easeOut,
                        builder: (context, v, _) => Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: v.clamp(0.03, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: data[i].color ??
                                    (data[i].highlight ? col : Color.alphaBlend(col.withValues(alpha: .3), c.surface3)),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(4)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(data[i].label, style: context.text.cap.copyWith(color: c.ink3)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Animated line/area chart (`LineChart`).
class MnLineChart extends StatelessWidget {
  const MnLineChart({
    super.key,
    required this.values,
    this.height = 160,
    this.color,
    this.labels,
    this.minValue,
    this.maxValue,
    this.showDots = false,
  });

  final List<double> values;
  final double height;
  final Color? color;
  final List<String>? labels;
  final double? minValue;
  final double? maxValue;
  final bool showDots;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = color ?? c.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1300),
            curve: MnMotion.easeOut,
            builder: (context, t, _) => CustomPaint(
              painter: _LinePainter(
                values: values,
                color: col,
                surface: c.surface,
                progress: t,
                min: minValue,
                max: maxValue,
                showDots: showDots,
              ),
            ),
          ),
        ),
        if (labels != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (final l in labels!) Text(l, style: context.text.cap.copyWith(color: c.ink3))],
            ),
          ),
        ],
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.values,
    required this.color,
    required this.surface,
    required this.progress,
    this.min,
    this.max,
    this.showDots = false,
  });

  final List<double> values;
  final Color color;
  final Color surface;
  final double progress;
  final double? min;
  final double? max;
  final bool showDots;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    const pad = 8.0;
    final hi = max ?? values.reduce(math.max) * 1.1;
    final lo = min ?? values.reduce(math.min) * .85;
    final range = (hi - lo) == 0 ? 1 : hi - lo;
    Offset pt(int i) => Offset(
          pad + i * (size.width - pad * 2) / (values.length - 1),
          size.height - pad - ((values[i] - lo) / range) * (size.height - pad * 2),
        );

    // Smooth curve via Catmull-Rom → cubic Bézier.
    final line = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (var i = 0; i < values.length - 1; i++) {
      final p0 = pt(math.max(0, i - 1));
      final p1 = pt(i);
      final p2 = pt(i + 1);
      final p3 = pt(math.min(values.length - 1, i + 2));
      final c1 = p1 + (p2 - p0) / 6;
      final c2 = p2 - (p3 - p1) / 6;
      line.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
    }

    final metric = line.computeMetrics().first;
    final drawn = metric.extractPath(0, metric.length * progress);

    final area = Path.from(line)
      ..lineTo(pt(values.length - 1).dx, size.height - pad)
      ..lineTo(pt(0).dx, size.height - pad)
      ..close();
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));
    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: .22), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.restore();

    canvas.drawPath(
      drawn,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (progress > .98) {
      for (var i = 0; i < values.length; i++) {
        if (!showDots && i != values.length - 1) continue;
        final p = pt(i);
        canvas.drawCircle(p, 6.2, Paint()..color = surface);
        canvas.drawCircle(p, 4.5, Paint()..color = color);
      }
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) =>
      old.progress != progress || old.values != values || old.color != color;
}

/// Progress donut (`DonutRing`).
class MnDonut extends StatelessWidget {
  const MnDonut({super.key, required this.value, this.size = 92, this.stroke = 11, this.color, this.child});

  /// 0..100
  final double value;
  final double size;
  final double stroke;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value / 100),
        duration: const Duration(milliseconds: 1000),
        curve: MnMotion.easeOut,
        builder: (context, v, child) => CustomPaint(
          painter: _DonutPainter(v, stroke, color ?? c.primary, c.fill),
          child: Center(child: child),
        ),
        child: child,
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.value, this.stroke, this.color, this.track);
  final double value;
  final double stroke;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(stroke / 2, stroke / 2, size.width - stroke, size.height - stroke);
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, p..color = track);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * value, false, p..color = color);
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.value != value || old.color != color;
}

/// Stat tile with tinted icon, value, label and optional delta (`TStat`).
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
    this.delta,
    this.deltaUp = true,
  });

  final MnIconData icon;
  final String value;
  final String label;
  final Color? color;
  final String? delta;
  final bool deltaUp;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = color ?? c.primary;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(20), boxShadow: MnShadows.sm(c)),
      child: Semantics(
        label: '$label: $value${delta == null ? '' : ', ${deltaUp ? 'up' : 'down'} $delta'}',
        excludeSemantics: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: col.withValues(alpha: .14), borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: MnIcon(icon, size: 20, color: col),
                ),
                const Spacer(),
                if (delta != null)
                  Row(
                    children: [
                      Transform.flip(
                        flipY: !deltaUp,
                        child: MnIcon(MnIcons.trend, size: 14, stroke: 2.4, color: deltaUp ? c.green : c.red),
                      ),
                      const SizedBox(width: 3),
                      Text(delta!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: deltaUp ? c.green : c.red)),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 14),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: context.text.title2.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
              ),
            ),
            const SizedBox(height: 3),
            Text(label, style: context.text.sub.copyWith(color: c.ink3), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
