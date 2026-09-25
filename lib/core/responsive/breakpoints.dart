import 'package:flutter/widgets.dart';

enum ScreenType { phone, tablet, tabletLandscape }

/// Layout breakpoints. Width drives the layout (not device type) so split
/// screen / Stage Manager / foldables get the right shell automatically.
abstract final class Breakpoints {
  static const tablet = 700.0;
  static const tabletLandscape = 1100.0;

  static ScreenType of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  static ScreenType fromWidth(double w) {
    if (w >= tabletLandscape) return ScreenType.tabletLandscape;
    if (w >= tablet) return ScreenType.tablet;
    return ScreenType.phone;
  }
}
