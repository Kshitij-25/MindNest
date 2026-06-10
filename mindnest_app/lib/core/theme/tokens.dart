import 'package:flutter/material.dart';

/// MindNest design tokens — moss green · neutral surfaces · Apple HIG · light + dark.
/// Mirrors the CSS custom properties from the design's `styles.css`.
@immutable
class MnColors extends ThemeExtension<MnColors> {
  const MnColors({
    required this.brightness,
    required this.moss50,
    required this.moss100,
    required this.moss200,
    required this.moss300,
    required this.moss400,
    required this.moss500,
    required this.moss600,
    required this.moss700,
    required this.moss800,
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
    required this.mood,
    required this.green,
    required this.amber,
    required this.red,
    required this.blue,
    required this.topic,
    required this.paper,
    required this.streak,
  });

  final Brightness brightness;

  final Color moss50,
      moss100,
      moss200,
      moss300,
      moss400,
      moss500,
      moss600,
      moss700,
      moss800;
  final Color primary, primaryPress, onPrimary, primaryTint, primaryRing;
  final Color clay, clayTint;
  final Color bg, bg2, surface, surface2, surface3, elevated;
  final Color ink, ink2, ink3, ink4;
  final Color hairline, hairline2, fill, fill2;

  /// 5-point mood palette (index 0 == level 1 "struggling" … index 4 == "great").
  final List<Color> mood;
  final Color green, amber, red, blue;

  /// 5 muted topic-tag accents.
  final List<Color> topic;
  final Color paper, streak;

  bool get isDark => brightness == Brightness.dark;

  /// Mood color for level 1..5.
  Color moodColor(int level) => mood[(level - 1).clamp(0, 4)];

  static const _topicMap = {
    'Anxiety': 0,
    'Calm': 0,
    'Stress': 1,
    'Self-care': 1,
    'Sleep': 2,
    'Mindfulness': 3,
    'Growth': 3,
    'Gratitude': 3,
    'Relationships': 4,
    'Therapy': 4,
  };

  /// Topic-tag color matching the design's TOPIC_COLORS map.
  Color topicColor(String name) {
    final i = _topicMap[name];
    return i == null ? moss500 : topic[i];
  }

  // ---- soft, green-tinted shadows ----
  List<BoxShadow> get shSm => isDark
      ? const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ]
      : const [
          BoxShadow(
            color: Color(0x0D1F2818),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x0A1F2818),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ];

  List<BoxShadow> get shMd => isDark
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
      : const [
          BoxShadow(
            color: Color(0x0A1F2818),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x0F1F2818),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ];

  List<BoxShadow> get shLg => isDark
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
      : const [
          BoxShadow(
            color: Color(0x121F2818),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
          BoxShadow(
            color: Color(0x171F2818),
            blurRadius: 56,
            offset: Offset(0, 26),
          ),
        ];

  List<BoxShadow> primaryGlow() => [
    BoxShadow(color: primaryRing, blurRadius: 16, offset: const Offset(0, 6)),
  ];

  factory MnColors.light() => const MnColors(
    brightness: Brightness.light,
    moss50: Color(0xFFF1F5EE),
    moss100: Color(0xFFE3EDDD),
    moss200: Color(0xFFCBDDC1),
    moss300: Color(0xFFABC79C),
    moss400: Color(0xFF8DAE7B),
    moss500: Color(0xFF7C9D6B),
    moss600: Color(0xFF67854F),
    moss700: Color(0xFF506B3D),
    moss800: Color(0xFF3D5330),
    primary: Color(0xFF5C7C45),
    primaryPress: Color(0xFF4D6A39),
    onPrimary: Color(0xFFFFFFFF),
    primaryTint: Color(0xFFE9F0E2),
    primaryRing: Color(0x2E5C7C45), // rgba(92,124,69,0.18)
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
    hairline: Color(0x141F2519), // rgba(31,37,25,0.08)
    hairline2: Color(0x1F1F2519), // 0.12
    fill: Color(0x0D1F2519), // 0.05
    fill2: Color(0x141F2519), // 0.08
    mood: [
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
    topic: [
      Color(0xFF6E9AA6),
      Color(0xFFA6886B),
      Color(0xFF8B8FB0),
      Color(0xFF6F9A78),
      Color(0xFFB0848B),
    ],
    paper: Color(0xFFFBFBF7),
    streak: Color(0xFFC98A4E),
  );

  factory MnColors.dark() => const MnColors(
    brightness: Brightness.dark,
    // moss scale is shared (not overridden in dark)
    moss50: Color(0xFFF1F5EE),
    moss100: Color(0xFFE3EDDD),
    moss200: Color(0xFFCBDDC1),
    moss300: Color(0xFFABC79C),
    moss400: Color(0xFF8DAE7B),
    moss500: Color(0xFF7C9D6B),
    moss600: Color(0xFF67854F),
    moss700: Color(0xFF506B3D),
    moss800: Color(0xFF3D5330),
    primary: Color(0xFF84A86F),
    primaryPress: Color(0xFF739663),
    onPrimary: Color(0xFF12170D),
    primaryTint: Color(0xFF232C1B),
    primaryRing: Color(0x3884A86F), // rgba(132,168,111,0.22)
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
    hairline: Color(0x14FFFFFF), // rgba(255,255,255,0.08)
    hairline2: Color(0x21FFFFFF), // 0.13
    fill: Color(0x0FFFFFFF), // 0.06
    fill2: Color(0x1AFFFFFF), // 0.1
    mood: [
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
    topic: [
      Color(0xFF7FA9B4),
      Color(0xFFB89A7C),
      Color(0xFF9DA1BE),
      Color(0xFF84AD8C),
      Color(0xFFC0959B),
    ],
    paper: Color(0xFF1B2016),
    streak: Color(0xFFD6A766),
  );

  @override
  MnColors copyWith() => this;

  @override
  MnColors lerp(ThemeExtension<MnColors>? other, double t) {
    if (other is! MnColors) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    List<Color> cl(List<Color> a, List<Color> b) => [
      for (var i = 0; i < a.length; i++) c(a[i], b[i]),
    ];
    return MnColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      moss50: c(moss50, other.moss50),
      moss100: c(moss100, other.moss100),
      moss200: c(moss200, other.moss200),
      moss300: c(moss300, other.moss300),
      moss400: c(moss400, other.moss400),
      moss500: c(moss500, other.moss500),
      moss600: c(moss600, other.moss600),
      moss700: c(moss700, other.moss700),
      moss800: c(moss800, other.moss800),
      primary: c(primary, other.primary),
      primaryPress: c(primaryPress, other.primaryPress),
      onPrimary: c(onPrimary, other.onPrimary),
      primaryTint: c(primaryTint, other.primaryTint),
      primaryRing: c(primaryRing, other.primaryRing),
      clay: c(clay, other.clay),
      clayTint: c(clayTint, other.clayTint),
      bg: c(bg, other.bg),
      bg2: c(bg2, other.bg2),
      surface: c(surface, other.surface),
      surface2: c(surface2, other.surface2),
      surface3: c(surface3, other.surface3),
      elevated: c(elevated, other.elevated),
      ink: c(ink, other.ink),
      ink2: c(ink2, other.ink2),
      ink3: c(ink3, other.ink3),
      ink4: c(ink4, other.ink4),
      hairline: c(hairline, other.hairline),
      hairline2: c(hairline2, other.hairline2),
      fill: c(fill, other.fill),
      fill2: c(fill2, other.fill2),
      mood: cl(mood, other.mood),
      green: c(green, other.green),
      amber: c(amber, other.amber),
      red: c(red, other.red),
      blue: c(blue, other.blue),
      topic: cl(topic, other.topic),
      paper: c(paper, other.paper),
      streak: c(streak, other.streak),
    );
  }
}

/// Corner radii (matches --r-* tokens).
abstract class MnRadius {
  static const double xs = 10;
  static const double sm = 14;
  static const double md = 20;
  static const double lg = 26;
  static const double xl = 34;
  static const double pill = 999;
}

/// Mood labels for levels 1..5.
const moodLabels = ['Struggling', 'Low', 'Okay', 'Good', 'Great'];

/// Blend [color] over [base] keeping [amount] of [color] (CSS `color-mix`).
Color mix(Color base, Color color, double amount) =>
    Color.lerp(base, color, amount)!;

/// `color-mix(in srgb, color X%, transparent)` — a translucent tint of [color].
Color tint(Color color, double amount) => color.withValues(alpha: amount);

/// Convenient access to the active MindNest palette.
extension MnColorsContext on BuildContext {
  MnColors get c => Theme.of(this).extension<MnColors>()!;
}
