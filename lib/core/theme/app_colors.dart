import 'package:flutter/material.dart';

/// Design tokens from the MindNest design system (moss green · neutral surfaces).
///
/// Exposed as a [ThemeExtension] so every widget reads colours through
/// `context.colors` and light/dark switch for free.
@immutable
class MnColors extends ThemeExtension<MnColors> {
  const MnColors({
    required this.primary,
    required this.primaryPress,
    required this.onPrimary,
    required this.primaryTint,
    required this.primaryRing,
    required this.clay,
    required this.clayTint,
    required this.bg,
    required this.bg2,
    required this.surface,
    required this.surface2,
    required this.surface3,
    required this.elevated,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.ink4,
    required this.hairline,
    required this.hairline2,
    required this.fill,
    required this.fill2,
    required this.moods,
    required this.green,
    required this.amber,
    required this.red,
    required this.blue,
    required this.topics,
    required this.paper,
    required this.streak,
    required this.shadowTint,
    required this.isDark,
  });

  // Moss scale is shared across themes.
  static const moss50 = Color(0xFFF1F5EE);
  static const moss100 = Color(0xFFE3EDDD);
  static const moss200 = Color(0xFFCBDDC1);
  static const moss300 = Color(0xFFABC79C);
  static const moss400 = Color(0xFF8DAE7B);
  static const moss500 = Color(0xFF7C9D6B);
  static const moss600 = Color(0xFF67854F);
  static const moss700 = Color(0xFF506B3D);
  static const moss800 = Color(0xFF3D5330);

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [moss500, Color(0xFF5C7C45)],
  );

  final Color primary;
  final Color primaryPress;
  final Color onPrimary;
  final Color primaryTint;
  final Color primaryRing;
  final Color clay;
  final Color clayTint;
  final Color bg;
  final Color bg2;
  final Color surface;
  final Color surface2;
  final Color surface3;
  final Color elevated;
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color ink4;
  final Color hairline;
  final Color hairline2;
  final Color fill;
  final Color fill2;

  /// Five-point mood palette, index 0 = struggling … 4 = great.
  final List<Color> moods;
  final Color green;
  final Color amber;
  final Color red;
  final Color blue;

  /// Muted topic tag palette (5 colours).
  final List<Color> topics;
  final Color paper;
  final Color streak;
  final Color shadowTint;
  final bool isDark;

  Color mood(int level) => moods[(level - 1).clamp(0, 4)];

  static const light = MnColors(
    primary: Color(0xFF5C7C45),
    primaryPress: Color(0xFF4D6A39),
    onPrimary: Color(0xFFFFFFFF),
    primaryTint: Color(0xFFE9F0E2),
    primaryRing: Color(0x2E5C7C45),
    clay: Color(0xFFC68C6A),
    clayTint: Color(0xFFF3E7DD),
    bg: Color(0xFFF3F4F0),
    bg2: Color(0xFFEDEFE9),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFFAFBF8),
    surface3: Color(0xFFF4F6F1),
    elevated: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2519),
    ink2: Color(0xFF4C5446),
    ink3: Color(0xFF828B7B),
    ink4: Color(0xFFA9B0A2),
    hairline: Color(0x141F2519),
    hairline2: Color(0x1F1F2519),
    fill: Color(0x0D1F2519),
    fill2: Color(0x141F2519),
    moods: [
      Color(0xFFC58A86),
      Color(0xFFC8A578),
      Color(0xFFC9C079),
      Color(0xFF9DBE82),
      Color(0xFF6FA98C),
    ],
    green: Color(0xFF4F8A5B),
    amber: Color(0xFFC99A4E),
    red: Color(0xFFC2685F),
    blue: Color(0xFF5E86B0),
    topics: [
      Color(0xFF6E9AA6),
      Color(0xFFA6886B),
      Color(0xFF8B8FB0),
      Color(0xFF6F9A78),
      Color(0xFFB0848B),
    ],
    paper: Color(0xFFFBFBF7),
    streak: Color(0xFFC98A4E),
    shadowTint: Color(0xFF1F2818),
    isDark: false,
  );

  static const dark = MnColors(
    primary: Color(0xFF84A86F),
    primaryPress: Color(0xFF739663),
    onPrimary: Color(0xFF12170D),
    primaryTint: Color(0xFF232C1B),
    primaryRing: Color(0x3884A86F),
    clay: Color(0xFFD4A382),
    clayTint: Color(0xFF2E251D),
    bg: Color(0xFF0E110B),
    bg2: Color(0xFF14180F),
    surface: Color(0xFF181C13),
    surface2: Color(0xFF1E2318),
    surface3: Color(0xFF232820),
    elevated: Color(0xFF20251A),
    ink: Color(0xFFECEFE6),
    ink2: Color(0xFFAEB6A6),
    ink3: Color(0xFF79806E),
    ink4: Color(0xFF565C4D),
    hairline: Color(0x14FFFFFF),
    hairline2: Color(0x21FFFFFF),
    fill: Color(0x0FFFFFFF),
    fill2: Color(0x1AFFFFFF),
    moods: [
      Color(0xFFC58A86),
      Color(0xFFC8A578),
      Color(0xFFC9C079),
      Color(0xFF9DBE82),
      Color(0xFF6FA98C),
    ],
    green: Color(0xFF6FB07C),
    amber: Color(0xFFD6B06A),
    red: Color(0xFFD58178),
    blue: Color(0xFF7DA3CC),
    topics: [
      Color(0xFF7FA9B4),
      Color(0xFFB89A7C),
      Color(0xFF9DA1BE),
      Color(0xFF84AD8C),
      Color(0xFFC0959B),
    ],
    paper: Color(0xFF1B2016),
    streak: Color(0xFFD6A766),
    shadowTint: Color(0xFF000000),
    isDark: true,
  );

  /// High-contrast overrides (accessibility setting).
  MnColors highContrast() => isDark
      ? copyWith(
          ink: const Color(0xFFFFFFFF),
          ink2: const Color(0xFFE4E9DC),
          ink3: const Color(0xFFC2C9B8),
          ink4: const Color(0xFF9AA28C),
          hairline: const Color(0x66FFFFFF),
          hairline2: const Color(0x99FFFFFF),
          fill: const Color(0x24FFFFFF),
          fill2: const Color(0x38FFFFFF),
          primary: const Color(0xFFB6D89C),
          primaryTint: const Color(0xFF2A3720),
          onPrimary: const Color(0xFF0A0F05),
          surface: const Color(0xFF14180F),
          surface3: const Color(0xFF1F261A),
          bg: const Color(0xFF0A0C08),
        )
      : copyWith(
          ink: const Color(0xFF000000),
          ink2: const Color(0xFF1A1F14),
          ink3: const Color(0xFF303629),
          ink4: const Color(0xFF4A5040),
          hairline: const Color(0x520F1408),
          hairline2: const Color(0x800F1408),
          fill: const Color(0x1A0F1408),
          fill2: const Color(0x2E0F1408),
          primary: const Color(0xFF2F4321),
          primaryPress: const Color(0xFF233318),
          primaryTint: const Color(0xFFDDE7D2),
          surface: const Color(0xFFFFFFFF),
          surface2: const Color(0xFFFFFFFF),
          surface3: const Color(0xFFF2F5EE),
          bg: const Color(0xFFFFFFFF),
        );

  @override
  MnColors copyWith({
    Color? primary,
    Color? primaryPress,
    Color? onPrimary,
    Color? primaryTint,
    Color? primaryRing,
    Color? clay,
    Color? clayTint,
    Color? bg,
    Color? bg2,
    Color? surface,
    Color? surface2,
    Color? surface3,
    Color? elevated,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? ink4,
    Color? hairline,
    Color? hairline2,
    Color? fill,
    Color? fill2,
    List<Color>? moods,
    Color? green,
    Color? amber,
    Color? red,
    Color? blue,
    List<Color>? topics,
    Color? paper,
    Color? streak,
    Color? shadowTint,
    bool? isDark,
  }) {
    return MnColors(
      primary: primary ?? this.primary,
      primaryPress: primaryPress ?? this.primaryPress,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryTint: primaryTint ?? this.primaryTint,
      primaryRing: primaryRing ?? this.primaryRing,
      clay: clay ?? this.clay,
      clayTint: clayTint ?? this.clayTint,
      bg: bg ?? this.bg,
      bg2: bg2 ?? this.bg2,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      surface3: surface3 ?? this.surface3,
      elevated: elevated ?? this.elevated,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      ink4: ink4 ?? this.ink4,
      hairline: hairline ?? this.hairline,
      hairline2: hairline2 ?? this.hairline2,
      fill: fill ?? this.fill,
      fill2: fill2 ?? this.fill2,
      moods: moods ?? this.moods,
      green: green ?? this.green,
      amber: amber ?? this.amber,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      topics: topics ?? this.topics,
      paper: paper ?? this.paper,
      streak: streak ?? this.streak,
      shadowTint: shadowTint ?? this.shadowTint,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  MnColors lerp(ThemeExtension<MnColors>? other, double t) {
    if (other is! MnColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    List<Color> ll(List<Color> a, List<Color> b) => [
      for (var i = 0; i < a.length; i++) l(a[i], b[i]),
    ];
    return MnColors(
      primary: l(primary, other.primary),
      primaryPress: l(primaryPress, other.primaryPress),
      onPrimary: l(onPrimary, other.onPrimary),
      primaryTint: l(primaryTint, other.primaryTint),
      primaryRing: l(primaryRing, other.primaryRing),
      clay: l(clay, other.clay),
      clayTint: l(clayTint, other.clayTint),
      bg: l(bg, other.bg),
      bg2: l(bg2, other.bg2),
      surface: l(surface, other.surface),
      surface2: l(surface2, other.surface2),
      surface3: l(surface3, other.surface3),
      elevated: l(elevated, other.elevated),
      ink: l(ink, other.ink),
      ink2: l(ink2, other.ink2),
      ink3: l(ink3, other.ink3),
      ink4: l(ink4, other.ink4),
      hairline: l(hairline, other.hairline),
      hairline2: l(hairline2, other.hairline2),
      fill: l(fill, other.fill),
      fill2: l(fill2, other.fill2),
      moods: ll(moods, other.moods),
      green: l(green, other.green),
      amber: l(amber, other.amber),
      red: l(red, other.red),
      blue: l(blue, other.blue),
      topics: ll(topics, other.topics),
      paper: l(paper, other.paper),
      streak: l(streak, other.streak),
      shadowTint: l(shadowTint, other.shadowTint),
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}
