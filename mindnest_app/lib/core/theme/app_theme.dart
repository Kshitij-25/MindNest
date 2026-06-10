import 'package:flutter/material.dart';

import 'tokens.dart';

/// Builds the [ThemeData] for a given brightness, attaching the [MnColors]
/// palette as a theme extension so widgets resolve tokens via `context.c`.
ThemeData buildMindNestTheme(Brightness brightness) {
  final mn = brightness == Brightness.dark ? MnColors.dark() : MnColors.light();
  final base = ThemeData(brightness: brightness, useMaterial3: true);

  return base.copyWith(
    extensions: [mn],
    scaffoldBackgroundColor: mn.bg,
    canvasColor: mn.bg,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: mn.primary,
          brightness: brightness,
        ).copyWith(
          primary: mn.primary,
          onPrimary: mn.onPrimary,
          surface: mn.surface,
          onSurface: mn.ink,
        ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: mn.primary,
      selectionColor: mn.primaryRing,
      selectionHandleColor: mn.primary,
    ),
    // Default text color for the whole app.
    textTheme: base.textTheme.apply(bodyColor: mn.ink, displayColor: mn.ink),
  );
}
