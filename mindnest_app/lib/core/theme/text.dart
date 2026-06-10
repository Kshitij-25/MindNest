import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// MindNest type scale. UI text uses the platform system font (SF on Apple,
/// Roboto on Android — matching the design's `-apple-system` stack); display
/// and emotional moments use the Newsreader serif.
///
/// CSS `letter-spacing` is in `em`; Flutter's is in logical px, so each style
/// bakes in `tracking * fontSize`.
abstract class MnText {
  static TextStyle serif({
    double size = 20,
    FontWeight weight = FontWeight.w500,
    double height = 1.2,
    Color? color,
  }) => GoogleFonts.newsreader(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: -0.01 * size,
    color: color,
  );

  static TextStyle get display => serif(size: 34, height: 1.1);

  static const title1 = TextStyle(
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.56,
  );
  static const title2 = TextStyle(
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.44,
  );
  static const title3 = TextStyle(
    fontSize: 19,
    height: 1.25,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.285,
  );
  static const headline = TextStyle(
    fontSize: 17,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.17,
  );
  static const body = TextStyle(
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.16,
  );
  static const callout = TextStyle(
    fontSize: 15,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
  static const sub = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w500,
  );
  static const foot = TextStyle(
    fontSize: 13,
    height: 1.35,
    fontWeight: FontWeight.w500,
  );
  static const cap = TextStyle(
    fontSize: 11.5,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.23,
  );
}
