/// App-wide constants. Keep values that are truly global here; feature-scoped
/// values belong inside their feature.
abstract class AppConstants {
  static const String appName = 'MindNest';
  static const String appTagline = 'A calmer space for your mind';
  static const String appVersion = '2.0.0';

  /// Layout
  static const double maxContentWidth = 460;
  static const double screenPadding = 20;

  /// Motion (mirrors the design's easing/duration tokens)
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 550);
}
