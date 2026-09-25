import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../adaptive/adaptive.dart';
import '../theme/app_tokens.dart';
import '../utils/context_x.dart';
import 'mn_icon.dart';
import 'pressable.dart';

/// Adaptive toggle: CupertinoSwitch on iOS, Material 3 Switch on Android,
/// both tinted with the MindNest primary.
class MnToggle extends StatelessWidget {
  const MnToggle({super.key, required this.value, required this.onChanged, this.semanticLabel});

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final toggle = context.isIOS
        ? CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: c.primary,
            inactiveTrackColor: c.hairline2,
          )
        : Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: c.onPrimary,
            activeTrackColor: c.primary,
            inactiveTrackColor: c.fill2,
            inactiveThumbColor: c.ink3,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          );
    return Semantics(label: semanticLabel, toggled: value, child: toggle);
  }
}

/// Segmented control with a sliding spring thumb (`.seg`).
class MnSegmented<T> extends StatelessWidget {
  const MnSegmented({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.labelOf,
  });

  final List<T> options;
  final T value;
  final ValueChanged<T> onChanged;
  final String Function(T) labelOf;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final idx = options.indexOf(value).clamp(0, options.length - 1);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(MnRadii.xs)),
      child: LayoutBuilder(builder: (context, box) {
        final w = box.maxWidth / options.length;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 320),
              curve: MnMotion.easeSpring,
              left: idx * w,
              top: 0,
              bottom: 0,
              width: w,
              child: Container(
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: MnShadows.sm(c),
                ),
              ),
            ),
            Row(
              children: [
                for (final o in options)
                  Expanded(
                    child: Semantics(
                      selected: o == value,
                      button: true,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Adaptive.tap(context);
                          onChanged(o);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: AnimatedDefaultTextStyle(
                            duration: MnMotion.base,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: o == value ? c.ink : c.ink2,
                            ),
                            child: Text(labelOf(o), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

/// Thin progress bar (`.progress`).
class MnProgressBar extends StatelessWidget {
  const MnProgressBar({super.key, required this.value, this.height = 6, this.color});

  final double value;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      value: '${(value * 100).round()}%',
      child: Container(
        height: height,
        decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(999)),
        alignment: Alignment.centerLeft,
        child: LayoutBuilder(
          builder: (context, box) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: MnMotion.easeOut,
            width: box.maxWidth * value.clamp(0, 1),
            decoration: BoxDecoration(color: color ?? c.primary, borderRadius: BorderRadius.circular(999)),
          ),
        ),
      ),
    );
  }
}

/// Chunky slider with white thumb (onboarding `Slider`).
class MnSlider extends StatelessWidget {
  const MnSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 10,
    this.color,
    this.semanticLabel,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: semanticLabel,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 10,
          activeTrackColor: color ?? c.primary,
          inactiveTrackColor: c.fill2,
          thumbColor: Colors.white,
          overlayColor: c.primaryRing,
          thumbShape: const _WhiteThumb(),
          trackShape: const RoundedRectSliderTrackShape(),
          tickMarkShape: SliderTickMarkShape.noTickMark,
          showValueIndicator: ShowValueIndicator.never,
        ),
        child: Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          onChanged: (v) {
            if (v.round() != value) Adaptive.tap(context);
            onChanged(v.round());
          },
        ),
      ),
    );
  }
}

class _WhiteThumb extends SliderComponentShape {
  const _WhiteThumb();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(28, 28);

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center.translate(0, 2),
      14,
      Paint()
        ..color = Colors.black.withValues(alpha: .18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(center, 14, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      14,
      Paint()
        ..color = Colors.black.withValues(alpha: .08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }
}

/// Rounded check box (`CheckMini`).
class MnCheckbox extends StatelessWidget {
  const MnCheckbox({super.key, required this.value, required this.onChanged, this.round = false, this.size = 22});

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool round;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      checked: value,
      child: Pressable(
        onTap: () => onChanged(!value),
        scale: 0.9,
        child: AnimatedContainer(
          duration: MnMotion.base,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: value ? c.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(round ? size : 7),
            border: value ? null : Border.all(color: c.hairline2, width: round ? 2 : 1.5),
          ),
          alignment: Alignment.center,
          child: value ? MnIcon(MnIcons.check, size: size * .64, color: c.onPrimary, stroke: 3) : null,
        ),
      ),
    );
  }
}

/// Five-dot / star rating display.
class MnRating extends StatelessWidget {
  const MnRating({super.key, required this.value, this.size = 13});

  final double value;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: 'Rated ${value.toStringAsFixed(1)} out of 5',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MnIcon(MnIcons.star, size: size, color: const Color(0xFF7C9D6B), filled: true, stroke: 0.01),
          const SizedBox(width: 3),
          Text(value.toStringAsFixed(1), style: TextStyle(fontWeight: FontWeight.w700, fontSize: size + 1, color: c.ink)),
        ],
      ),
    );
  }
}

/// Row of stars for review input/display.
class MnStars extends StatelessWidget {
  const MnStars({super.key, required this.value, this.size = 14, this.onChanged});

  final int value;
  final double size;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: onChanged == null ? null : () => onChanged!(i),
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: MnIcon(MnIcons.star, size: size, filled: true, stroke: 0.01, color: i <= value ? const Color(0xFF7C9D6B) : c.fill2),
            ),
          ),
      ],
    );
  }
}

/// Verified-professional shield.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key, this.size = 16});
  final double size;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Verified professional',
        child: MnIcon(MnIcons.shield, size: size, color: context.colors.primary, semanticLabel: 'Verified professional'),
      );
}
