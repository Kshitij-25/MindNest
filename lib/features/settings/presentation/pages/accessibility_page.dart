import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../domain/entities/app_preferences.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_widgets.dart';

const _typeStops = [(0.85, 'XS'), (0.95, 'S'), (1.0, 'M'), (1.15, 'L'), (1.3, 'XL')];

/// Live accessibility controls: dynamic type, reduced motion, high contrast.
@RoutePage()
class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<SettingsCubit, AppPreferences>(
      builder: (context, p) {
        final cubit = context.read<SettingsCubit>();
        final controls = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MnCard(
              radius: 22,
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Text size', style: context.text.title3)),
                      Text('${(p.textScale * 100).round()}%',
                          style: context.text.sub.copyWith(fontWeight: FontWeight.w700, color: c.primary)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Scales every label, heading and body text on top of your system setting.',
                      style: context.text.sub.copyWith(color: c.ink3)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      for (final (i, (v, label)) in _typeStops.indexed) ...[
                        if (i > 0) const SizedBox(width: 8),
                        Expanded(
                          child: Semantics(
                            button: true,
                            selected: (p.textScale - v).abs() < .01,
                            label: 'Text size $label',
                            excludeSemantics: true,
                            child: Pressable(
                              onTap: () => cubit.setTextScale(v),
                              child: AnimatedContainer(
                                duration: MnMotion.base,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: (p.textScale - v).abs() < .01 ? c.primaryTint : c.surface,
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(color: (p.textScale - v).abs() < .01 ? c.primary : c.hairline, width: 1.5),
                                ),
                                child: Text(
                                  'A',
                                  textScaler: TextScaler.noScaling,
                                  style: TextStyle(
                                    fontSize: 11 + i * 2.5,
                                    fontWeight: FontWeight.w700,
                                    color: (p.textScale - v).abs() < .01 ? c.primary : c.ink2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ToggleCard(
              icon: MnIcons.pulse,
              title: 'Reduced motion',
              subtitle: 'Removes transitions and looping animations.',
              value: p.reduceMotion,
              onChanged: cubit.setReduceMotion,
            ),
            const SizedBox(height: 18),
            ToggleCard(
              icon: MnIcons.eye,
              title: 'High contrast',
              subtitle: 'Boosts text and border contrast.',
              value: p.highContrast,
              onChanged: cubit.setHighContrast,
            ),
          ],
        );

        return MnPage(
          header: const MnNavHeader(title: 'Accessibility'),
          maxWidth: 1080,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Every control below applies live across the whole app.',
                style: context.text.body.copyWith(color: c.ink2),
              ),
              const SizedBox(height: 22),
              controls,
            ],
          ),
        );
      },
    );
  }
}
