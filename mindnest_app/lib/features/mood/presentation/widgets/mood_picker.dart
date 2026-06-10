import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

/// Horizontal row of 5 selectable mood faces.
class MoodPicker extends StatelessWidget {
  const MoodPicker({
    super.key,
    required this.value,
    required this.onPick,
    this.size = 48,
  });
  final int value;
  final ValueChanged<int> onPick;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var l = 1; l <= 5; l++)
          GestureDetector(
            onTap: () => onPick(l),
            child: AnimatedScale(
              scale: value == l ? 1.1 : 0.92,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              child: AnimatedOpacity(
                opacity: value == l ? 1 : 0.45,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: value == l
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: c.surface, spreadRadius: 3),
                            BoxShadow(color: c.primaryRing, spreadRadius: 5),
                          ],
                        )
                      : null,
                  child: MoodFace(level: l, size: size),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
