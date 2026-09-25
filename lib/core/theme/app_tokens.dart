import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Corner radii.
abstract final class MnRadii {
  static const xs = 10.0;
  static const sm = 14.0;
  static const md = 20.0;
  static const lg = 26.0;
  static const xl = 34.0;
  static const pill = 999.0;
}

/// Spacing scale.
abstract final class MnSpace {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

/// Motion tokens mirroring the prototype's CSS easings and durations.
abstract final class MnMotion {
  static const ease = Cubic(.22, .61, .36, 1);
  static const easeOut = Cubic(.16, 1, .3, 1);
  static const easeSpring = Cubic(.34, 1.56, .64, 1);

  static const fast = Duration(milliseconds: 150);
  static const base = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 450);
  static const page = Duration(milliseconds: 440);
}

/// Soft, green-tinted shadows.
abstract final class MnShadows {
  static List<BoxShadow> sm(MnColors c) => c.isDark
      ? const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ]
      : [
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .04),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ];

  static List<BoxShadow> md(MnColors c) => c.isDark
      ? const [
          BoxShadow(
            color: Color(0x73000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ]
      : [
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ];

  static List<BoxShadow> lg(MnColors c) => c.isDark
      ? const [
          BoxShadow(
            color: Color(0x8C000000),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 60,
            offset: Offset(0, 30),
          ),
        ]
      : [
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .07),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: c.shadowTint.withValues(alpha: .09),
            blurRadius: 56,
            offset: const Offset(0, 26),
          ),
        ];

  static List<BoxShadow> ring(MnColors c, {double spread = 4}) => [
    BoxShadow(color: c.primaryRing, spreadRadius: spread),
  ];
}
