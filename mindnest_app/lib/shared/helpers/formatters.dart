import 'package:flutter/material.dart';

/// Small, dependency-free formatting helpers shared across features.
abstract class Formatters {
  static String wordCount(String text) {
    final trimmed = text.trim();
    final n = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;
    return '$n ${n == 1 ? 'word' : 'words'}';
  }

  static String initials(String name) => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0])
      .join()
      .toUpperCase();

  static String firstName(String name) => name.split(' ').first;

  static String mediumDate(BuildContext context, DateTime date) =>
      MaterialLocalizations.of(context).formatMediumDate(date);
}
