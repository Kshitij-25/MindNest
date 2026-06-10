/// Release-phase switch. While `mvp1` is true the app presents only the
/// **MVP 1 wellness** surface: professional / marketplace / community elements
/// are hidden in place (not deleted) so the next MVP can restore them by
/// flipping this single flag back to `false`.
abstract class AppPhase {
  /// MVP 1 — wellness only. Flip to `false` to bring back the full app.
  static const bool mvp1 = true;
}
