import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Type scale. UI text uses the platform font (SF Pro on iOS, Roboto on
/// Android) — the adaptive part — while display text uses Newsreader serif.
@immutable
class MnTypography extends ThemeExtension<MnTypography> {
  const MnTypography({required this.ink});

  final Color ink;

  TextStyle get _base => TextStyle(color: ink, letterSpacing: -0.16);

  TextStyle serif({
    double size = 22,
    FontWeight weight = FontWeight.w500,
    double height = 1.15,
  }) => GoogleFonts.newsreader(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: -0.01 * size,
    color: ink,
  );

  TextStyle get display => serif(size: 34, height: 1.1);
  TextStyle get title1 => _base.copyWith(
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.56,
  );
  TextStyle get title2 => _base.copyWith(
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.44,
  );
  TextStyle get title3 => _base.copyWith(
    fontSize: 19,
    height: 1.25,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.28,
  );
  TextStyle get headline =>
      _base.copyWith(fontSize: 17, height: 1.3, fontWeight: FontWeight.w600);
  TextStyle get body =>
      _base.copyWith(fontSize: 16, height: 1.45, fontWeight: FontWeight.w400);
  TextStyle get callout => _base.copyWith(
    fontSize: 15,
    height: 1.4,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  TextStyle get sub => _base.copyWith(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  TextStyle get foot => _base.copyWith(
    fontSize: 13,
    height: 1.35,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  TextStyle get cap => _base.copyWith(
    fontSize: 11.5,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.23,
  );

  @override
  MnTypography copyWith({Color? ink}) => MnTypography(ink: ink ?? this.ink);

  @override
  MnTypography lerp(ThemeExtension<MnTypography>? other, double t) {
    if (other is! MnTypography) return this;
    return MnTypography(ink: Color.lerp(ink, other.ink, t)!);
  }
}
