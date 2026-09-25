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

        final preview = MnCard(
          radius: 22,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Live preview', style: context.text.title3),
              const SizedBox(height: 4),
              Text('Reflects your settings in real time', style: context.text.sub.copyWith(color: c.ink3)),
              const SizedBox(height: 16),
              MnCard(
                style: MnCardStyle.inset,
                radius: 18,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('How are you feeling?', style: context.text.title3),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        for (var l = 1; l <= 5; l++)
                          Expanded(
                            child: Column(
                              children: [
                                MoodFace(level: l, size: 44, soft: l != 4),
                                const SizedBox(height: 6),
                                Text(moodLabel(l),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.text.cap.copyWith(color: l == 4 ? c.ink : c.ink3, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MnCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const MnAvatar(name: 'Amara Okafor', size: 44, photo: true),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Next session', style: context.text.headline),
                                Text('Thu · 4:00 PM', style: context.text.sub.copyWith(color: c.ink2)),
                              ],
                            ),
                          ),
                          MnIcon(MnIcons.chevR, size: 18, color: c.ink4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    MnButton(label: 'Join session', icon: MnIcons.video, size: MnButtonSize.small, onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        );

        const badges = [
          (MnIcons.checkCircle, 'WCAG 2.2 AA', 'Contrast, targets, focus'),
          (MnIcons.user, 'VoiceOver & TalkBack', 'Full label coverage'),
          (MnIcons.sliders, 'Dynamic Type', 'Honors system text size'),
          (MnIcons.pulse, 'Reduced motion', 'Honors system setting'),
        ];

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
              if (context.isTablet)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Expanded(child: controls), const SizedBox(width: 20), Expanded(child: preview)],
                )
              else ...[
                controls,
                const SizedBox(height: 18),
                preview,
              ],
              const SizedBox(height: 22),
              ResponsiveGrid(
                columns: responsive(context, phone: 2, tablet: 4),
                spacing: 14,
                runSpacing: 14,
                children: [
                  for (final b in badges)
                    MnCard(
                      style: MnCardStyle.flat,
                      radius: 20,
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconTile(size: 38, radius: 11, child: MnIcon(b.$1, size: 19, color: c.primary)),
                          const SizedBox(height: 12),
                          Text(b.$2, style: context.text.headline),
                          const SizedBox(height: 3),
                          Text(b.$3, style: context.text.cap.copyWith(color: c.ink3)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
