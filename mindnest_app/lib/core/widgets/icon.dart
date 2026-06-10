import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// MindNest stroke icon set — 24×24, `currentColor`, ported verbatim from the
/// design's `components.jsx` so glyphs match pixel-for-pixel.
const Map<String, String> mnIconPaths = {
  'home': 'M3 10.2 12 3l9 7.2M5 9v10a1 1 0 0 0 1 1h3v-6h6v6h3a1 1 0 0 0 1-1V9',
  'compass': 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM15.5 8.5l-2 5-5 2 2-5 5-2Z',
  'message':
      'M21 11.5a8.5 8.5 0 0 1-12.2 7.7L3 21l1.8-5.8A8.5 8.5 0 1 1 21 11.5Z',
  'user':
      'M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM5 20c.7-3.6 3.5-5.5 7-5.5s6.3 1.9 7 5.5',
  'heart':
      'M12 20s-7-4.4-9.2-8.4C1.2 8.7 2.6 5.5 5.7 5.1 7.7 4.8 9.4 6 12 8.3c2.6-2.3 4.3-3.5 6.3-3.2 3.1.4 4.5 3.6 2.9 6.5C19 15.6 12 20 12 20Z',
  'calendar':
      'M7 3v3M17 3v3M3.5 9h17M5 5h14a1.5 1.5 0 0 1 1.5 1.5V19A1.5 1.5 0 0 1 19 20.5H5A1.5 1.5 0 0 1 3.5 19V6.5A1.5 1.5 0 0 1 5 5Z',
  'bell':
      'M18 8.5a6 6 0 1 0-12 0c0 6-2.5 7.5-2.5 7.5h17S18 14.5 18 8.5ZM10 19.5a2.2 2.2 0 0 0 4 0',
  'search': 'M11 18a7 7 0 1 0 0-14 7 7 0 0 0 0 14ZM20 20l-4-4',
  'sliders': 'M4 7h10M18 7h2M4 17h2M10 17h10M14 4v6M8 14v6',
  'chevL': 'M15 5l-7 7 7 7',
  'chevR': 'M9 5l7 7-7 7',
  'chevDown': 'M5 9l7 7 7-7',
  'plus': 'M12 5v14M5 12h14',
  'check': 'M4 12.5 9.5 18 20 6.5',
  'x': 'M6 6l12 12M18 6 6 18',
  'star':
      'M12 3.5l2.5 5.4 5.9.7-4.4 4 1.2 5.8L12 16.6 6.8 19.4 8 13.6l-4.4-4 5.9-.7L12 3.5Z',
  'shield':
      'M12 3.5 5 6v6c0 4.5 3 7 7 8.5 4-1.5 7-4 7-8.5V6l-7-2.5ZM9 12l2 2 4-4',
  'clock': 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 7.5V12l3 2',
  'camera':
      'M4 8.5h3l1.5-2h7L17 8.5h3a1 1 0 0 1 1 1V18a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a1 1 0 0 1 1-1ZM12 16.5a3.2 3.2 0 1 0 0-6.4 3.2 3.2 0 0 0 0 6.4Z',
  'upload': 'M12 16V4m0 0L7.5 8.5M12 4l4.5 4.5M5 18.5h14',
  'doc':
      'M14 3v5h5M14 3H6.5A1.5 1.5 0 0 0 5 4.5v15A1.5 1.5 0 0 0 6.5 21h11a1.5 1.5 0 0 0 1.5-1.5V8l-5-5ZM9 13h6M9 16.5h6',
  'mail': 'M3.5 7.5h17v10a1 1 0 0 1-1 1h-15a1 1 0 0 1-1-1v-10ZM4 8l8 6 8-6',
  'lock':
      'M7 10V8a5 5 0 0 1 10 0v2M5.5 10h13a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1h-13a1 1 0 0 1-1-1v-8a1 1 0 0 1 1-1Z',
  'eye':
      'M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12ZM12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z',
  'eyeOff':
      'M4 4l16 16M9.5 9.6A3 3 0 0 0 14.4 14.5M7 7.2C4.3 8.8 2.5 12 2.5 12s3.5 6.5 9.5 6.5c1.6 0 3-.4 4.2-1M11 5.6c.3 0 .7-.1 1-.1 6 0 9.5 6.5 9.5 6.5s-.8 1.4-2.2 2.9',
  'send': 'M4.5 12 20 4.5l-4 15.5-4.5-6L17 7M11.5 14l-3 3.5',
  'phone':
      'M6.5 4h3l1.5 4-2 1.5a11 11 0 0 0 5 5l1.5-2 4 1.5v3a1.5 1.5 0 0 1-1.6 1.5C12 22.5 5.5 16 4.5 9.6A1.5 1.5 0 0 1 6 8',
  'video':
      'M3.5 7.5h11a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1h-11a1 1 0 0 1-1-1v-7a1 1 0 0 1 1-1ZM15.5 11l5-3v8l-5-3',
  'sun':
      'M12 16a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM12 2.5v2M12 19.5v2M4.5 4.5l1.5 1.5M18 18l1.5 1.5M2.5 12h2M19.5 12h2M4.5 19.5 6 18M18 6l1.5-1.5',
  'moon': 'M20 13.5A8 8 0 1 1 10.5 4 6.5 6.5 0 0 0 20 13.5Z',
  'edit': 'M4 20h4L19 9l-4-4L4 16v4ZM14 6l4 4',
  'logout':
      'M15 12H5m0 0 3.5-3.5M5 12l3.5 3.5M11 5h6a1.5 1.5 0 0 1 1.5 1.5v11A1.5 1.5 0 0 1 17 19h-6',
  'sparkle':
      'M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8L12 3ZM18.5 14l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8.8-2.2Z',
  'sleep': 'M8 6h5l-5 6h5M14 13h4l-4 5h4',
  'brain':
      'M9 4.5a2.5 2.5 0 0 0-2.5 2.5A2.5 2.5 0 0 0 4.5 9.5 2.5 2.5 0 0 0 6 14a2.5 2.5 0 0 0 3 3.5V4.5ZM15 4.5A2.5 2.5 0 0 1 17.5 7 2.5 2.5 0 0 1 19.5 9.5 2.5 2.5 0 0 1 18 14a2.5 2.5 0 0 1-3 3.5V4.5Z',
  'pulse': 'M3 12h3.5l2-6 3.5 12 2.5-7 1.5 1h5',
  'filter': 'M3.5 6h17M6.5 12h11M10 18h4',
  'arrowR': 'M5 12h14m0 0-6-6m6 6-6 6',
  'back': 'M15 5l-7 7 7 7',
  'more': 'M5 12h.01M12 12h.01M19 12h.01',
  'bookmark': 'M7 4h10a1 1 0 0 1 1 1v15l-6-4-6 4V5a1 1 0 0 1 1-1Z',
  'location':
      'M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11ZM12 13a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z',
  'globe':
      'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM3.5 12h17M12 3c2.5 2.4 3.8 5.6 3.8 9s-1.3 6.6-3.8 9c-2.5-2.4-3.8-5.6-3.8-9S9.5 5.4 12 3Z',
  'award':
      'M12 14a5 5 0 1 0 0-10 5 5 0 0 0 0 10ZM8.5 13l-1.5 8 5-2.5 5 2.5-1.5-8',
  'chat2':
      'M4 6.5A1.5 1.5 0 0 1 5.5 5h10A1.5 1.5 0 0 1 17 6.5v6A1.5 1.5 0 0 1 15.5 14H9l-4 3.5V6.5Z',
  'grid': 'M4 4h7v7H4zM13 4h7v7h-7zM4 13h7v7H4zM13 13h7v7h-7z',
  'trend': 'M4 16l5-5 3 3 7-7m0 0h-4m4 0v4',
  'info': 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 11v5M12 7.5h.01',
  'share':
      'M16 6l-4-4-4 4M12 2v13M5 12v6.5a1.5 1.5 0 0 0 1.5 1.5h11a1.5 1.5 0 0 0 1.5-1.5V12',
  'pen': 'M5 19l1-4.5L16.5 4a2.1 2.1 0 0 1 3 3L9 17.5 5 19ZM14 6.5l3 3',
  'image':
      'M4 5h16a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1ZM3.5 16l4.5-4 3 2.5 4.5-4.5 5 5M9 10.5a1.6 1.6 0 1 0 0-3.2 1.6 1.6 0 0 0 0 3.2Z',
  'flame':
      'M12 21c3.3 0 6-2.3 6-5.6 0-3.7-3-5.2-2.3-9.4C13 7 11 8.6 10.4 11 9 9.6 9 8 9 6.4 6.7 8 6 11 6 13.6 6 17.6 8.7 21 12 21Z',
  'layers':
      'M12 3l9 4.5-9 4.5-9-4.5 9-4.5ZM3 12.5l9 4.5 9-4.5M3 16.5l9 4.5 9-4.5',
  'bookOpen':
      'M12 6.4C10.4 5 8 4.6 4 5v13c4-.4 6.4 0 8 1.4M12 6.4C13.6 5 16 4.6 20 5v13c-4-.4-6.4 0-8 1.4M12 6.4V19.4',
  'lightbulb':
      'M9.5 18.5h5M10.5 21.5h3M12 3a6 6 0 0 0-3.8 10.6c.6.5 1.1 1.1 1.3 1.9h5c.2-.8.7-1.4 1.3-1.9A6 6 0 0 0 12 3Z',
  'tag':
      'M3.5 11V5.5A2 2 0 0 1 5.5 3.5H11l9.5 9.5-7 7L3.5 11ZM7.5 8a1 1 0 1 0 0-.01',
  'checkCircle': 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM8 12l3 3 5.5-5.5',
  'feather':
      'M19 5a5.5 5.5 0 0 0-7.8 0L5 11.2V19h7.8l6.2-6.2A5.5 5.5 0 0 0 19 5ZM5 19l7-7M14 8l-3 3',
  'smile':
      'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM8.5 14c.8 1.2 2 2 3.5 2s2.7-.8 3.5-2M9 9.5h.01M15 9.5h.01',
  'zap': 'M13 3 5 13h6l-1 8 8-10h-6l1-8Z',
  'wind':
      'M3 9h11a2.5 2.5 0 1 0-2.5-2.5M3 14h15a2.5 2.5 0 1 1-2.5 2.5M3 12h7',
  'droplet':
      'M12 3.5c3 3.6 6 6.9 6 10.2A6 6 0 0 1 6 13.7c0-3.3 3-6.6 6-10.2Z',
  'repeat':
      'M4 9a4 4 0 0 1 4-4h9m0 0-3-3m3 3-3 3M20 15a4 4 0 0 1-4 4H7m0 0 3 3m-3-3 3-3',
  'target':
      'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 16.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM12 12h.01',
};

/// Serializes a [Color] to an `rgba(...)` string for inline SVG.
String svgRgba(Color c) {
  final r = (c.r * 255).round();
  final g = (c.g * 255).round();
  final b = (c.b * 255).round();
  return 'rgba($r,$g,$b,${c.a.toStringAsFixed(3)})';
}

/// A single MindNest stroke/fill icon rendered from the shared path set.
class MnIcon extends StatelessWidget {
  const MnIcon(
    this.name, {
    super.key,
    this.size = 24,
    this.stroke = 2,
    required this.color,
    this.fill,
  });

  final String name;
  final double size;
  final double stroke;
  final Color color;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    final d = mnIconPaths[name] ?? '';
    final fillStr = fill == null ? 'none' : svgRgba(fill!);
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" width="$size" height="$size" viewBox="0 0 24 24" '
        'fill="$fillStr" stroke="${svgRgba(color)}" stroke-width="$stroke" '
        'stroke-linecap="round" stroke-linejoin="round"><path d="$d"/></svg>';
    return SvgPicture.string(svg, width: size, height: size);
  }
}
