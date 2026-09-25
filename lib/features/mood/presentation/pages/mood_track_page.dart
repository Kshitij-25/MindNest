import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_track_cubit.dart';

@RoutePage()
class MoodTrackPage extends StatelessWidget {
  const MoodTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoodTrackCubit>(),
      child: BlocBuilder<MoodTrackCubit, MoodTrackState>(
        builder: (context, s) => AnimatedSwitcher(
          duration: MnMotion.slow,
          child: s.saved ? const _Saved() : _Form(s: s),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.s});
  final MoodTrackState s;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<MoodTrackCubit>();
    return MnPage(
      maxWidth: 560,
      header: const MnNavHeader(title: 'Track mood'),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Center(child: PopIn(key: ValueKey(s.level), child: MoodFace(level: s.level, size: 120))),
          const SizedBox(height: 18),
          Text(moodLabel(s.level), textAlign: TextAlign.center, style: context.text.title2.copyWith(color: c.mood(s.level))),
          const SizedBox(height: 22),
          MoodPicker(value: s.level, onChanged: cubit.setLevel, size: 48),
          const SizedBox(height: 30),
          Text('What’s shaping it?', style: context.text.headline),
          const SizedBox(height: 12),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: [
              for (final f in moodFactors)
                MnChip(label: f, outline: true, selected: s.factors.contains(f), onTap: () => cubit.toggleFactor(f)),
            ],
          ),
          const SizedBox(height: 26),
          Text.rich(
            TextSpan(
              text: 'Add a note ',
              children: [TextSpan(text: '(optional)', style: context.text.callout.copyWith(color: c.ink3))],
            ),
            style: context.text.headline,
          ),
          const SizedBox(height: 12),
          MnTextField(hint: 'What’s on your mind today?', maxLines: 4, minLines: 3, onChanged: cubit.setNote),
        ],
      ),
      bottom: MnButton(label: 'Save check-in', loading: s.saving, onPressed: cubit.save),
    );
  }
}

class _Saved extends StatelessWidget {
  const _Saved();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SuccessCheck(color: c.primary, ring: c.primaryRing),
                  const SizedBox(height: 24),
                  FadeUp(child: Text('Mood logged', style: context.text.title2)),
                  const SizedBox(height: 8),
                  FadeUp(
                    child: Text(
                      'Thanks for checking in. Small moments of awareness add up.',
                      textAlign: TextAlign.center,
                      style: context.text.body.copyWith(color: c.ink2),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FadeUp(
                    child: Column(
                      children: [
                        MnButton(
                          label: 'View mood history',
                          onPressed: () => context.router.replace(const MoodHistoryRoute()),
                        ),
                        const SizedBox(height: 10),
                        MnButton.ghost(label: 'Back to home', onPressed: () => context.router.maybePop()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
