import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Simple brand glyphs (Apple / Google) for the social sign-in buttons,
/// rendered as inline SVG so they tint to the supplied [color].
class BrandGlyph extends StatelessWidget {
  const BrandGlyph(
    this.brand, {
    super.key,
    this.size = 18,
    required this.color,
  });

  final String brand;
  final double size;
  final Color color;

  static String _rgba(Color c) {
    final r = (c.r * 255).round();
    final g = (c.g * 255).round();
    final b = (c.b * 255).round();
    return 'rgba($r,$g,$b,${c.a.toStringAsFixed(3)})';
  }

  @override
  Widget build(BuildContext context) {
    final fill = _rgba(color);
    final inner = brand == 'apple'
        ? '<path fill="$fill" d="M16.4 12.6c0-2 1.6-3 1.7-3-.9-1.4-2.4-1.6-2.9-1.6-1.2-.1-2.4.7-3 .7-.6 0-1.6-.7-2.6-.7-1.3 0-2.6.8-3.3 2-1.4 2.5-.4 6.1 1 8.1.7 1 1.5 2.1 2.5 2 1-.04 1.4-.65 2.6-.65 1.2 0 1.6.65 2.6.63 1.1-.02 1.8-1 2.4-2 .8-1.1 1.1-2.2 1.1-2.3 0 0-2.1-.8-2.1-3.2ZM14.5 6.3c.5-.6.9-1.5.8-2.4-.8.03-1.7.5-2.3 1.2-.5.6-.9 1.5-.8 2.4.9.07 1.8-.5 2.3-1.2Z"/>'
        : '<path fill="$fill" d="M21 12.2c0-.7-.06-1.3-.18-1.9H12v3.6h5.05c-.22 1.2-.88 2.2-1.87 2.85v2.35h3.02C19.96 17.4 21 15 21 12.2Z"/>'
              '<path fill="$fill" d="M12 21c2.52 0 4.64-.83 6.2-2.25l-3.03-2.35c-.84.56-1.92.9-3.17.9-2.44 0-4.5-1.65-5.24-3.86H3.62v2.42A9 9 0 0 0 12 21Z"/>'
              '<path fill="$fill" d="M6.76 13.44A5.4 5.4 0 0 1 6.76 10.56V8.14H3.62a9 9 0 0 0 0 7.72l3.14-2.42Z"/>'
              '<path fill="$fill" d="M12 6.7c1.37 0 2.6.47 3.57 1.4l2.68-2.68C16.63 3.9 14.51 3 12 3a9 9 0 0 0-8.38 5.14l3.14 2.42C7.5 8.35 9.56 6.7 12 6.7Z"/>';
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 24 24">$inner</svg>';
    return SvgPicture.string(svg, width: size, height: size);
  }
}
