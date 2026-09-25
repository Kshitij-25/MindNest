import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Tinted icon square heading auth screens.
class AuthIconHeader extends StatelessWidget {
  const AuthIconHeader({super.key, required this.icon});
  final MnIconData icon;

  @override
  Widget build(BuildContext context) => IconTile(
        size: 60,
        radius: 18,
        child: MnIcon(icon, size: 28, color: context.colors.primary, stroke: 1.9),
      );
}

/// "or" divider.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          children: [
            const Expanded(child: Hairline()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('or', style: context.text.foot.copyWith(color: context.colors.ink3)),
            ),
            const Expanded(child: Hairline()),
          ],
        ),
      );
}

/// Password strength meter (4 segments).
class PasswordStrength extends StatelessWidget {
  const PasswordStrength({super.key, required this.password, required this.score});

  final String password;
  final int score;

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();
    final c = context.colors;
    const labels = ['Too short', 'Weak', 'Good', 'Strong'];
    final colors = [c.ink4, c.amber, MnColors.moss500, c.green];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                for (var i = 0; i < 4; i++) ...[
                  if (i > 0) const SizedBox(width: 4),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      decoration: BoxDecoration(
                        color: i <= score ? colors[score] : c.fill2,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(labels[score], style: context.text.foot.copyWith(color: colors[score])),
        ],
      ),
    );
  }
}

class AppleGlyph extends StatelessWidget {
  const AppleGlyph({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.apple, size: 21, color: color ?? context.colors.ink, semanticLabel: 'Apple');
}

class GoogleGlyph extends StatelessWidget {
  const GoogleGlyph({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        child: const Text(
          'G',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: Color(0xFF4285F4)),
        ),
      );
}

/// Shows a failure message as a floating snackbar.
void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
