import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../cubit/questionnaire_cubit.dart';
import '../widgets/question_steps.dart';

@RoutePage()
class QuestionnairePage extends StatelessWidget {
  const QuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuestionnaireCubit>(),
      child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
        listenWhen: (a, b) => !a.done && b.done,
        listener: (context, s) => context.router.replaceAll([const WelcomeRoute()]),
        builder: (context, s) {
          final cubit = context.read<QuestionnaireCubit>();
          final c = context.colors;
          final a = s.answers;
          final step = switch (s.step) {
            0 => MoodStep(value: a.mood, onChanged: cubit.setMood),
            1 => StressStep(value: a.stress, onChanged: cubit.setStress),
            2 => AnxietyStep(value: a.anxiety, onChanged: cubit.setAnxiety),
            3 => SleepStep(value: a.sleep, onChanged: cubit.setSleep),
            _ => GoalsStep(selected: a.goals, onToggle: cubit.toggleGoal),
          };
          return PopScope(
            canPop: s.step == 0,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) cubit.back();
            },
            child: MnPage(
              maxWidth: 560,
              header: _ProgressHeader(
                step: s.step,
                onBack: () {
                  if (!cubit.back()) context.router.maybePop();
                },
              ),
              padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
              body: AnimatedSwitcher(
                duration: MnMotion.slow,
                switchInCurve: MnMotion.easeOut,
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween(begin: Offset(0, s.direction > 0 ? .04 : 0), end: Offset.zero).animate(anim),
                    child: child,
                  ),
                ),
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.topCenter,
                  children: [...previous.map((p) => IgnorePointer(child: Opacity(opacity: 0, child: p))), ?current],
                ),
                child: KeyedSubtree(key: ValueKey(s.step), child: step),
              ),
              bottom: MnButton(
                label: s.isLast ? 'Finish' : 'Continue',
                loading: s.saving,
                onPressed: s.canContinue ? cubit.next : null,
              ),
              background: c.bg,
            ),
          );
        },
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget implements PreferredSizeWidget {
  const _ProgressHeader({required this.step, required this.onBack});
  final int step;
  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    const total = QuestionnaireState.steps;
    return Padding(
      padding: EdgeInsets.fromLTRB(12, MediaQuery.paddingOf(context).top + 8, 20, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Row(
            children: [
              MnIconButton(icon: MnIcons.back, tooltip: 'Back', onPressed: onBack),
              const SizedBox(width: 10),
              Expanded(child: MnProgressBar(value: (step + 1) / total)),
              const SizedBox(width: 14),
              SizedBox(
                width: 30,
                child: Text(
                  '${step + 1}/$total',
                  textAlign: TextAlign.right,
                  style: context.text.foot.copyWith(color: context.colors.ink3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
