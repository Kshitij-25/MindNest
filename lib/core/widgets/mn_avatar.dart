import 'package:flutter/material.dart';

import '../utils/context_x.dart';
import 'mn_icon.dart';

const _hues = [
  Color(0xFF7C9D6B),
  Color(0xFF6FA98C),
  Color(0xFFA6886B),
  Color(0xFF8B95B0),
  Color(0xFFB0848B),
  Color(0xFF6E9AA6),
];

/// Deterministic hue for a name (same hash as the prototype).
Color avatarHue(String name) {
  var h = 0;
  for (final code in name.codeUnits) {
    h = (code + ((h << 5) - h)).toSigned(32);
  }
  return _hues[h.abs() % _hues.length];
}

String initialsOf(String name) => name
    .split(' ')
    .where((w) => w.isNotEmpty)
    .take(2)
    .map((w) => w[0])
    .join()
    .toUpperCase();

/// Initials or photo-placeholder avatar with optional ring and online dot.
class MnAvatar extends StatelessWidget {
  const MnAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.photo = false,
    this.ring = false,
    this.online = false,
  });

  final String name;
  final double size;
  final bool photo;
  final bool ring;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final hue = avatarHue(name);
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: photo ? null : hue,
        gradient: photo
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [hue, avatarHue('${name}x')],
              )
            : null,
        boxShadow: ring
            ? [
                BoxShadow(color: c.primaryRing, spreadRadius: 4.5),
                BoxShadow(color: c.surface, spreadRadius: 3),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: photo
          ? MnIcon(MnIcons.user, size: size * .5, stroke: 1.6, color: Colors.white.withValues(alpha: .92))
          : Text(
              initialsOf(name),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: (size * .38).roundToDouble()),
            ),
    );
    return Semantics(
      label: name,
      image: true,
      child: online
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                avatar,
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: size * .28,
                    height: size * .28,
                    decoration: BoxDecoration(
                      color: c.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: c.surface, width: 2),
                    ),
                  ),
                ),
              ],
            )
          : avatar,
    );
  }
}
