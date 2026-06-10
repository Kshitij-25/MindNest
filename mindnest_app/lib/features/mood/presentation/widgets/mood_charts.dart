import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Circular streak ring (rounded progress arc).
class StreakRing extends StatelessWidget {
  const StreakRing({
    super.key,
    required this.value,
    required this.track,
    required this.color,
    required this.child,
    this.size = 76,
  });
  final double value;
  final Color track, color;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: _RingPainter(value: value, track: track, color: color),
      child: Center(child: child),
    ),
  );
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.value, required this.track, required this.color});
  final double value;
  final Color track, color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 5;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = track,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.color != color || old.track != track;
}

/// Smoothed monthly mood line with gradient fill.
class MoodLineChart extends StatelessWidget {
  const MoodLineChart({
    super.key,
    required this.data,
    required this.color,
    required this.surface,
  });
  final List<int> data;
  final Color color, surface;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size(double.infinity, 130),
    painter: _LinePainter(data, color, surface),
  );
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.data, this.color, this.surface);
  final List<int> data;
  final Color color, surface;

  @override
  void paint(Canvas canvas, Size size) {
    const pad = 6.0;
    const minV = 1, maxV = 5;
    final pts = <Offset>[];
    for (var i = 0; i < data.length; i++) {
      final x = pad + (i / (data.length - 1)) * (size.width - pad * 2);
      final y =
          pad +
          (1 - (data[i] - minV) / (maxV - minV)) * (size.height - pad * 2);
      pts.add(Offset(x, y));
    }
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    final area = Path.from(path)
      ..lineTo(size.width - pad, size.height - pad)
      ..lineTo(pad, size.height - pad)
      ..close();
    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.25), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = color,
    );
    for (var i = 0; i < pts.length; i += 4) {
      canvas.drawCircle(pts[i], 3, Paint()..color = surface);
      canvas.drawCircle(
        pts[i],
        3,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) =>
      old.data != data || old.color != color;
}
