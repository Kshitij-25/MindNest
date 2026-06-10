import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../cubit/mood_track_cubit.dart';
import '../widgets/mood_picker.dart';

class MoodTrackPage extends StatelessWidget {
  const MoodTrackPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<MoodTrackCubit>(),
    child: const _MoodTrackView(),
  );
}

class _MoodTrackView extends StatefulWidget {
  const _MoodTrackView();
  @override
  State<_MoodTrackView> createState() => _MoodTrackViewState();
}

class _MoodTrackViewState extends State<_MoodTrackView> {
  final _note = TextEditingController();
  static const factors = [
    'Work',
    'Sleep',
    'Family',
    'Health',
    'Money',
    'Relationships',
    'Exercise',
    'Solitude',
  ];

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocBuilder<MoodTrackCubit, MoodTrackState>(
      builder: (context, state) {
        final cubit = context.read<MoodTrackCubit>();
        if (state.saved) {
          return MnScaffold(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SuccessCheck(),
                    const SizedBox(height: 24),
                    Text(
                      'Mood logged',
                      style: MnText.title2.copyWith(color: c.ink),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Text(
                        'Thanks for checking in. Small moments of awareness add up.',
                        textAlign: TextAlign.center,
                        style: MnText.body.copyWith(color: c.ink2),
                      ),
                    ),
                    const SizedBox(height: 32),
                    MnButton(
                      label: 'View mood history',
                      onPressed: () {
                        context.pop();
                        context.pushNamed(RouteNames.moodHistory);
                      },
                    ),
                    const SizedBox(height: 10),
                    MnButton(
                      label: 'Back to home',
                      variant: MnVariant.ghost,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return MnScaffold(
          child: Column(
            children: [
              SizedBox(height: safeTop(context)),
              NavHeader(title: 'Track mood', onBack: () => context.pop()),
              Expanded(
                child: NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
                    children: [
                      const SizedBox(height: 10),
                      Center(child: MoodFace(level: state.level, size: 120)),
                      const SizedBox(height: 18),
                      Center(
                        child: Text(
                          moodLabels[state.level - 1],
                          style: MnText.title2.copyWith(
                            color: c.moodColor(state.level),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      MoodPicker(value: state.level, onPick: cubit.setLevel),
                      const SizedBox(height: 30),
                      Text(
                        'What’s shaping it?',
                        style: MnText.headline.copyWith(color: c.ink),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 9,
                        runSpacing: 9,
                        children: [
                          for (final f in factors)
                            Chip2(
                              f,
                              active: state.factors.contains(f),
                              outline: !state.factors.contains(f),
                              onTap: () => cubit.toggleFactor(f),
                            ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Add a note ',
                            style: MnText.headline.copyWith(color: c.ink),
                          ),
                          Text(
                            '(optional)',
                            style: MnText.callout.copyWith(color: c.ink3),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      MnField(
                        hint: 'What’s on your mind today?',
                        controller: _note,
                        minLines: 3,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.error) ...[
                      Text(
                        'Couldn’t save — check your connection and try again.',
                        textAlign: TextAlign.center,
                        style: MnText.foot.copyWith(color: c.red),
                      ),
                      const SizedBox(height: 10),
                    ],
                    MnButton(
                      label: state.saving ? 'Saving…' : 'Save check-in',
                      onPressed:
                          state.saving ? null : () => cubit.save(_note.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
