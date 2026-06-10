import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/onboarding_answers.dart';
import '../../domain/usecases/onboarding_usecases.dart';

class QuestionnaireState extends Equatable {
  const QuestionnaireState({
    this.step = 0,
    this.mood = 4,
    this.stress = 5,
    this.sleep = 3,
    this.anxiety,
    this.goals = const {},
  });

  final int step;
  final int mood;
  final int stress;
  final int sleep;
  final int? anxiety;
  final Set<String> goals;

  /// Whether the current step allows advancing.
  bool get canNext => switch (step) {
    2 => anxiety != null,
    4 => goals.isNotEmpty,
    _ => true,
  };

  QuestionnaireState copyWith({
    int? step,
    int? mood,
    int? stress,
    int? sleep,
    int? anxiety,
    Set<String>? goals,
  }) => QuestionnaireState(
    step: step ?? this.step,
    mood: mood ?? this.mood,
    stress: stress ?? this.stress,
    sleep: sleep ?? this.sleep,
    anxiety: anxiety ?? this.anxiety,
    goals: goals ?? this.goals,
  );

  @override
  List<Object?> get props => [step, mood, stress, sleep, anxiety, goals];
}

@injectable
class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  QuestionnaireCubit(this._saveOnboarding) : super(const QuestionnaireState());
  final SaveOnboarding _saveOnboarding;

  void setMood(int mood) => emit(state.copyWith(mood: mood));
  void setStress(int stress) => emit(state.copyWith(stress: stress));
  void setSleep(int sleep) => emit(state.copyWith(sleep: sleep));
  void setAnxiety(int anxiety) => emit(state.copyWith(anxiety: anxiety));

  void toggleGoal(String goal) {
    final next = {...state.goals};
    next.contains(goal) ? next.remove(goal) : next.add(goal);
    emit(state.copyWith(goals: next));
  }

  /// Advances a step. On finishing the last step, persists the answers.
  /// Returns `true` once the questionnaire is complete (so the page can navigate).
  Future<bool> next() async {
    if (!state.canNext) return false;
    if (state.step < 4) {
      emit(state.copyWith(step: state.step + 1));
      return false;
    }
    await _saveOnboarding(
      OnboardingAnswers(
        mood: state.mood,
        stress: state.stress,
        sleep: state.sleep,
        anxiety: state.anxiety,
        goals: state.goals.toList(),
      ),
    );
    return true;
  }

  void back() {
    if (state.step > 0) emit(state.copyWith(step: state.step - 1));
  }
}
