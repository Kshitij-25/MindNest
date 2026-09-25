import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment.freezed.dart';

/// Answers from the onboarding questionnaire.
@freezed
abstract class Assessment with _$Assessment {
  const factory Assessment({
    @Default(4) int mood,
    @Default(5) int stress,
    int? anxiety,
    @Default(3) int sleep,
    @Default(<String>[]) List<String> goals,
  }) = _Assessment;
}

const anxietyOptions = [
  ('Rarely', 'Hardly ever on edge'),
  ('Sometimes', 'A few days a week'),
  ('Often', 'Most days I feel it'),
  ('Almost always', 'It’s with me daily'),
];

const onboardingGoals = [
  'Reduce anxiety',
  'Sleep better',
  'Manage stress',
  'Feel less alone',
  'Build confidence',
  'Process grief',
  'Work–life balance',
  'Improve focus',
];

String stressLabel(int v) => v <= 2
    ? 'Very calm'
    : v <= 4
        ? 'Manageable'
        : v <= 6
            ? 'Noticeable'
            : v <= 8
                ? 'High'
                : 'Overwhelming';

const sleepLabels = {1: 'Very poor', 2: 'Restless', 3: 'Okay', 4: 'Restful', 5: 'Deep & refreshing'};
