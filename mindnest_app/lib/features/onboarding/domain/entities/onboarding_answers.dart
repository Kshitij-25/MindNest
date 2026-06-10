import 'package:equatable/equatable.dart';

/// The user's responses to the onboarding questionnaire.
class OnboardingAnswers extends Equatable {
  const OnboardingAnswers({
    required this.mood,
    required this.stress,
    required this.sleep,
    required this.goals,
    this.anxiety,
  });

  final int mood;
  final int stress;
  final int sleep;
  final int? anxiety;
  final List<String> goals;

  @override
  List<Object?> get props => [mood, stress, sleep, anxiety, goals];
}
