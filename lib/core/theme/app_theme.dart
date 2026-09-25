import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData light({bool highContrast = false}) =>
      _build(highContrast ? MnColors.light.highContrast() : MnColors.light);

  static ThemeData dark({bool highContrast = false}) =>
      _build(highContrast ? MnColors.dark.highContrast() : MnColors.dark);

  static ThemeData _build(MnColors c) {
    final brightness = c.isDark ? Brightness.dark : Brightness.light;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.primaryTint,
      onPrimaryContainer: c.primary,
      secondary: c.clay,
      onSecondary: Colors.white,
      secondaryContainer: c.clayTint,
      onSecondaryContainer: c.clay,
      error: c.red,
      onError: Colors.white,
      surface: c.surface,
      onSurface: c.ink,
      onSurfaceVariant: c.ink2,
      outline: c.hairline2,
      outlineVariant: c.hairline,
      surfaceContainerHighest: c.surface3,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: [
        c,
        MnTypography(ink: c.ink),
      ],
      dividerTheme: DividerThemeData(
        color: c.hairline,
        thickness: 0.5,
        space: 0.5,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        foregroundColor: c.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: c.isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.primary,
        selectionColor: c.primaryRing,
        selectionHandleColor: c.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.elevated,
        modalBackgroundColor: c.elevated,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(MnRadii.xl)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.elevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MnRadii.lg),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.ink,
        contentTextStyle: TextStyle(color: c.bg, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MnRadii.sm),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.primary),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: c.primary,
        scaffoldBackgroundColor: c.bg,
      ),
      // Platform-appropriate page transitions (adaptive).
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
