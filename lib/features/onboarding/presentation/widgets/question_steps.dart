import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/assessment.dart';

class QuestionHeader extends StatelessWidget {
  const QuestionHeader({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(header: true, child: Text(title, style: context.text.title1)),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!, style: context.text.body.copyWith(color: context.colors.ink2)),
            ],
          ],
        ),
      );
}

class MoodStep extends StatelessWidget {
  const MoodStep({super.key, required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      children: [
        const QuestionHeader(
          title: 'How are you feeling today?',
          subtitle: 'There’s no wrong answer — just notice what’s true right now.',
        ),
        PopIn(key: ValueKey(value), child: MoodFace(level: value, size: 132)),
        const SizedBox(height: 26),
        Text(moodLabel(value), style: context.text.title3.copyWith(color: c.mood(value))),
        const SizedBox(height: 24),
        MoodPicker(value: value, onChanged: onChanged),
      ],
    );
  }
}

class StressStep extends StatelessWidget {
  const StressStep({super.key, required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const QuestionHeader(
          title: 'How much stress are you carrying?',
          subtitle: 'Slide to reflect your average over the past week.',
        ),
        MnCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Text('$value', style: context.text.serif(size: 56).copyWith(color: c.primary)),
              const SizedBox(height: 2),
              Text(stressLabel(value), style: context.text.headline.copyWith(color: c.ink2)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        MnSlider(value: value, onChanged: onChanged, semanticLabel: 'Stress level'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calm', style: context.text.foot.copyWith(color: c.ink3)),
              Text('Overwhelmed', style: context.text.foot.copyWith(color: c.ink3)),
            ],
          ),
        ),
      ],
    );
  }
}

class AnxietyStep extends StatelessWidget {
  const AnxietyStep({super.key, required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const QuestionHeader(
          title: 'How often do you feel anxious?',
          subtitle: 'This helps us pace your recommendations gently.',
        ),
        for (var i = 0; i < anxietyOptions.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          SelectableOption(
            title: anxietyOptions[i].$1,
            subtitle: anxietyOptions[i].$2,
            selected: value == i,
            onTap: () => onChanged(i),
          ),
        ],
      ],
    );
  }
}

/// Radio-style option card.
class SelectableOption extends StatelessWidget {
  const SelectableOption({super.key, required this.title, this.subtitle, required this.selected, required this.onTap});

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Pressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: MnMotion.base,
          curve: MnMotion.ease,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: selected ? c.primaryTint : c.surface,
            borderRadius: BorderRadius.circular(MnRadii.md),
            border: Border.all(color: selected ? c.primary : c.hairline, width: 1.5),
            boxShadow: selected ? MnShadows.ring(c) : MnShadows.sm(c),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.text.headline),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: context.text.callout.copyWith(color: c.ink2)),
                    ],
                  ],
                ),
              ),
              IgnorePointer(child: MnCheckbox(value: selected, onChanged: (_) {}, round: true, size: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class SleepStep extends StatelessWidget {
  const SleepStep({super.key, required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const QuestionHeader(title: 'How’s your sleep lately?', subtitle: 'Sleep and mood are closely linked.'),
        MnCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              IconTile(size: 72, radius: 22, child: MnIcon(MnIcons.sleep, size: 36, color: c.primary, stroke: 1.8)),
              const SizedBox(height: 16),
              Text(sleepLabels[value]!, style: context.text.title2.copyWith(color: c.primary)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 5; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: i <= value ? c.primary : c.fill2),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        MnSlider(value: value, onChanged: onChanged, min: 1, max: 5, semanticLabel: 'Sleep quality'),
      ],
    );
  }
}

class GoalsStep extends StatelessWidget {
  const GoalsStep({super.key, required this.selected, required this.onToggle});
  final List<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const QuestionHeader(title: 'What brings you here?', subtitle: 'Pick any that resonate — you can change these later.'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final g in onboardingGoals)
              MnChip(
                label: g,
                large: true,
                outline: true,
                selected: selected.contains(g),
                icon: selected.contains(g) ? MnIcons.check : null,
                onTap: () => onToggle(g),
              ),
          ],
        ),
      ],
    );
  }
}
