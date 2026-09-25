import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'pressable.dart';

const moodLabels = ['Struggling', 'Low', 'Okay', 'Good', 'Great'];

String moodLabel(int level) => moodLabels[(level - 1).clamp(0, 4)];

/// Soft mood expression (circle + two dots + mouth arc), levels 1..5.
class MoodFace extends StatelessWidget {
  const MoodFace({super.key, required this.level, this.size = 56, this.soft = true, this.color});

  final int level;
  final double size;
  final bool soft;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = color ?? c.mood(level);
    final bg = soft ? Color.alphaBlend(col.withValues(alpha: .26), c.surface) : col;
    final fg = soft ? col : Colors.white.withValues(alpha: .95);
    return Semantics(
      label: 'Mood: ${moodLabel(level)}',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: CustomPaint(size: Size.square(size * .62), painter: _FacePainter(level, fg)),
      ),
    );
  }
}

class _FacePainter extends CustomPainter {
  _FacePainter(this.level, this.color);

  final int level;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    canvas.scale(s);
    final eyeY = level >= 4 ? 10.5 : 11.0;
    final fill = Paint()..color = color;
    canvas.drawCircle(Offset(9, eyeY), 1.0, fill);
    canvas.drawCircle(Offset(15, eyeY), 1.0, fill);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round;
    final p = Path();
    switch (level) {
      case 1:
        p
          ..moveTo(9, 17)
          ..cubicTo(10, 15, 14, 15, 15, 17);
      case 2:
        p
          ..moveTo(9, 16.2)
          ..cubicTo(10, 15.2, 14, 15.2, 15, 16.2);
      case 3:
        p
          ..moveTo(9, 16)
          ..lineTo(15, 16);
      case 4:
        p
          ..moveTo(9, 15.5)
          ..cubicTo(10, 16.9, 14, 16.9, 15, 15.5);
      default:
        p
          ..moveTo(8.5, 15)
          ..cubicTo(9.7, 17.4, 14.3, 17.4, 15.5, 15);
    }
    canvas.drawPath(p, stroke);
  }

  @override
  bool shouldRepaint(_FacePainter old) => old.level != level || old.color != color;
}

/// Row of five tappable mood faces with a selected ring.
class MoodPicker extends StatelessWidget {
  const MoodPicker({super.key, required this.value, required this.onChanged, this.size = 52});
  final int? value;
  final ValueChanged<int> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var l = 1; l <= 5; l++)
          Semantics(
            selected: value == l,
            label: moodLabel(l),
            button: true,
            excludeSemantics: true,
            child: Pressable(
              onTap: () => onChanged(l),
              child: AnimatedScale(
                scale: value == l ? 1.12 : 1,
                duration: MnMotion.base,
                curve: MnMotion.easeSpring,
                child: AnimatedOpacity(
                  opacity: value == null || value == l ? 1 : .5,
                  duration: MnMotion.base,
                  child: AnimatedContainer(
                    duration: MnMotion.base,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: value == l
                          ? [BoxShadow(color: c.primaryRing, spreadRadius: 5), BoxShadow(color: c.surface, spreadRadius: 3)]
                          : const [],
                    ),
                    child: MoodFace(level: l, size: size),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

