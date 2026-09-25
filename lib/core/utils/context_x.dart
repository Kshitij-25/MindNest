import 'package:flutter/material.dart';

import '../responsive/breakpoints.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

extension MnContextX on BuildContext {
  MnColors get colors => Theme.of(this).extension<MnColors>()!;
  MnTypography get text => Theme.of(this).extension<MnTypography>()!;

  bool get isIOS {
    final p = Theme.of(this).platform;
    return p == TargetPlatform.iOS || p == TargetPlatform.macOS;
  }

  ScreenType get screenType => Breakpoints.of(this);
  bool get isTablet => screenType != ScreenType.phone;
  bool get isWide => screenType == ScreenType.tabletLandscape;

  /// Horizontal page gutter: 20 on phone, 28 on tablet.
  double get gutter => isTablet ? 28 : 20;

  /// True when the user asked the OS (or in-app setting) for reduced motion.
  bool get reduceMotion => MediaQuery.of(this).disableAnimations;
}
