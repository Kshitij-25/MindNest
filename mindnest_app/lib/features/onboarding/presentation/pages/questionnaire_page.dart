import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../cubit/questionnaire_cubit.dart';

class QuestionnairePage extends StatelessWidget {
  const QuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<QuestionnaireCubit>(),
    child: const _QuestionnaireView(),
  );
}

class _QuestionnaireView extends StatelessWidget {
  const _QuestionnaireView();

  static const _goals = [
    'Reduce anxiety',
    'Sleep better',
    'Manage stress',
    'Feel less alone',
    'Build confidence',
    'Process grief',
    'Work-life balance',
    'Improve focus',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
      builder: (context, state) {
        final cubit = context.read<QuestionnaireCubit>();
        final last = state.step == 4;
        return MnScaffold(
          child: Column(
            children: [
              SizedBox(height: safeTop(context)),
              // Top: back + progress + counter
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 16, 6),
                child: Row(
                  children: [
                    NavBtn(
                      icon: 'back',
                      onTap: () =>
                          state.step == 0 ? context.pop() : cubit.back(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: (state.step + 1) / 5,
                          minHeight: 6,
                          backgroundColor: c.fill2,
                          valueColor: AlwaysStoppedAnimation(c.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${state.step + 1}/5',
                      style: MnText.foot.copyWith(color: c.ink3),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NoGlow(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 320),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween(
                          begin: const Offset(0.06, 0),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: KeyedSubtree(
                      key: ValueKey(state.step),
                      child: _stepBody(context, state, cubit),
                    ),
                  ),
                ),
              ),
              // Footer
              Container(
                padding: EdgeInsets.fromLTRB(
                  24,
                  12,
                  24,
                  safeBottom(context) + 16,
                ),
                decoration: BoxDecoration(
                  color: c.bg,
                  border: Border(
                    top: BorderSide(color: c.hairline, width: 0.5),
                  ),
                ),
                child: MnButton(
                  label: last ? 'Finish' : 'Continue',
                  onPressed: state.canNext
                      ? () async {
                          final done = await cubit.next();
                          if (done && context.mounted) {
                            context.goNamed(RouteNames.welcome);
                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stepBody(
    BuildContext context,
    QuestionnaireState state,
    QuestionnaireCubit cubit,
  ) {
    switch (state.step) {
      case 0:
        return _MoodStep(level: state.mood, onPick: cubit.setMood);
      case 1:
        return _StressStep(value: state.stress, onChanged: cubit.setStress);
      case 2:
        return _AnxietyStep(value: state.anxiety, onChanged: cubit.setAnxiety);
      case 3:
        return _SleepStep(value: state.sleep, onChanged: cubit.setSleep);
      default:
        return _GoalsStep(
          goals: _goals,
          selected: state.goals,
          onToggle: cubit.toggleGoal,
        );
    }
  }
}

class _StepScroll extends StatelessWidget {
  const _StepScroll({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
    children: [
      FadeUp(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    ],
  );
}

// ---- Step 0: mood ----
class _MoodStep extends StatelessWidget {
  const _MoodStep({required this.level, required this.onPick});
  final int level;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return _StepScroll(
      children: [
        Text(
          'How are you feeling today?',
          style: MnText.title1.copyWith(color: c.ink),
        ),
        const SizedBox(height: 8),
        Text(
          'There’s no wrong answer — just notice what’s true right now.',
          style: MnText.body.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 36),
        Center(child: MoodFace(level: level, size: 132)),
        const SizedBox(height: 18),
        Center(
          child: Text(
            moodLabels[level - 1],
            style: MnText.title2.copyWith(color: c.moodColor(level)),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var l = 1; l <= 5; l++)
              Pressable(
                onTap: () => onPick(l),
                child: AnimatedScale(
                  scale: l == level ? 1.12 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Opacity(
                    opacity: l == level ? 1 : 0.5,
                    child: MoodFace(level: l, size: 52),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// ---- Step 1: stress ----
class _StressStep extends StatelessWidget {
  const _StressStep({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  static String _label(int v) {
    if (v <= 2) return 'Very calm';
    if (v <= 4) return 'Manageable';
    if (v <= 6) return 'Noticeable';
    if (v <= 8) return 'High';
    return 'Overwhelming';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return _StepScroll(
      children: [
        Text(
          'How’s your stress level?',
          style: MnText.title1.copyWith(color: c.ink),
        ),
        const SizedBox(height: 8),
        Text(
          'Slide to where you are on an average day this week.',
          style: MnText.body.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 30),
        MnCard(
          kind: MnCardKind.flat,
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
          child: Column(
            children: [
              Text('$value', style: MnText.serif(size: 56, color: c.primary)),
              const SizedBox(height: 4),
              Text(
                _label(value),
                style: MnText.headline.copyWith(color: c.ink),
              ),
              const SizedBox(height: 22),
              MnSlider(value: value, min: 0, max: 10, onChanged: onChanged),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Calm', style: MnText.foot.copyWith(color: c.ink3)),
                  Text(
                    'Overwhelmed',
                    style: MnText.foot.copyWith(color: c.ink3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---- Step 2: anxiety ----
class _AnxietyStep extends StatelessWidget {
  const _AnxietyStep({required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int> onChanged;

  static const _options = [
    ('Rarely', 'Anxiety doesn’t come up much for me.'),
    ('Sometimes', 'It surfaces now and then.'),
    ('Often', 'It’s a frequent companion.'),
    ('Almost always', 'It’s with me most of the day.'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return _StepScroll(
      children: [
        Text(
          'How often do you feel anxious?',
          style: MnText.title1.copyWith(color: c.ink),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps us tune what we surface for you.',
          style: MnText.body.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 26),
        for (var i = 0; i < _options.length; i++) ...[
          _OptionCard(
            title: _options[i].$1,
            subtitle: _options[i].$2,
            selected: value == i,
            onTap: () => onChanged(i),
          ),
          if (i != _options.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });
  final String title, subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MnCard(
      kind: MnCardKind.flat,
      onTap: onTap,
      color: selected ? c.primaryTint : c.surface,
      padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MnText.headline.copyWith(
                    color: selected ? c.primary : c.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(subtitle, style: MnText.foot.copyWith(color: c.ink2)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _Radio(selected: selected),
        ],
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? c.primary : Colors.transparent,
        border: Border.all(color: selected ? c.primary : c.hairline2, width: 2),
      ),
      alignment: Alignment.center,
      child: selected
          ? MnIcon('check', size: 14, color: c.onPrimary, stroke: 2.8)
          : null,
    );
  }
}

// ---- Step 3: sleep ----
class _SleepStep extends StatelessWidget {
  const _SleepStep({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  static const _labels = {
    1: 'Very poor',
    2: 'Restless',
    3: 'Okay',
    4: 'Restful',
    5: 'Deep & refreshing',
  };

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return _StepScroll(
      children: [
        Text(
          'How have you been sleeping?',
          style: MnText.title1.copyWith(color: c.ink),
        ),
        const SizedBox(height: 8),
        Text(
          'Rest shapes how the rest of the day feels.',
          style: MnText.body.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 30),
        Center(
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: c.primaryTint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: MnIcon('sleep', size: 44, color: c.primary, stroke: 1.9),
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Text(
            _labels[value]!,
            style: MnText.title2.copyWith(color: c.ink),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 1; i <= 5; i++)
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i <= value ? c.primary : c.fill2,
                ),
              ),
          ],
        ),
        const SizedBox(height: 26),
        MnSlider(value: value, min: 1, max: 5, onChanged: onChanged),
      ],
    );
  }
}

// ---- Step 4: goals ----
class _GoalsStep extends StatelessWidget {
  const _GoalsStep({
    required this.goals,
    required this.selected,
    required this.onToggle,
  });
  final List<String> goals;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return _StepScroll(
      children: [
        Text(
          'What brings you here?',
          style: MnText.title1.copyWith(color: c.ink),
        ),
        const SizedBox(height: 8),
        Text(
          'Pick what matters most — choose as many as you like.',
          style: MnText.body.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final g in goals)
              Chip2(
                g,
                height: 44,
                active: selected.contains(g),
                outline: !selected.contains(g),
                onTap: () => onToggle(g),
              ),
          ],
        ),
      ],
    );
  }
}
