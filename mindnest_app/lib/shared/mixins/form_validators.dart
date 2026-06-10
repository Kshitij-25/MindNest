/// Reusable, pure form-validation helpers for auth/profile forms.
mixin FormValidators {
  bool isValidEmail(String value) => value.contains('@') && value.contains('.');

  bool isValidPassword(String value) => value.length >= 6;

  bool isNotBlank(String value) => value.trim().isNotEmpty;

  /// 0..3 password strength score (matches the design's PwStrength meter).
  int passwordStrength(String pw) {
    if (pw.isEmpty) return 0;
    final hasDigit = RegExp(r'[0-9]').hasMatch(pw);
    return (pw.length ~/ 3 + (hasDigit ? 1 : 0)).clamp(0, 3);
  }
}
