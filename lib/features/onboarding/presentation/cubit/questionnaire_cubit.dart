import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/assessment.dart';
import '../../domain/usecases/onboarding_usecases.dart';

part 'questionnaire_cubit.freezed.dart';

@freezed
abstract class QuestionnaireState with _$QuestionnaireState {
  const factory QuestionnaireState({
    @Default(0) int step,
    @Default(1) int direction,
    @Default(Assessment()) Assessment answers,
    @Default(false) bool saving,
    @Default(false) bool done,
  }) = _QuestionnaireState;

  const QuestionnaireState._();

  static const steps = 5;

  bool get canContinue => switch (step) {
        2 => answers.anxiety != null,
        4 => answers.goals.isNotEmpty,
        _ => true,
      };

  bool get isLast => step == steps - 1;
}

@injectable
class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  QuestionnaireCubit(this._save) : super(const QuestionnaireState());
  final SaveAssessment _save;

  void setMood(int v) => emit(state.copyWith(answers: state.answers.copyWith(mood: v)));
  void setStress(int v) => emit(state.copyWith(answers: state.answers.copyWith(stress: v)));
  void setAnxiety(int v) => emit(state.copyWith(answers: state.answers.copyWith(anxiety: v)));
  void setSleep(int v) => emit(state.copyWith(answers: state.answers.copyWith(sleep: v)));

  void toggleGoal(String g) {
    final goals = [...state.answers.goals];
    goals.contains(g) ? goals.remove(g) : goals.add(g);
    emit(state.copyWith(answers: state.answers.copyWith(goals: goals)));
  }

  /// Returns false when stepping back past the first question.
  bool back() {
    if (state.step == 0) return false;
    emit(state.copyWith(step: state.step - 1, direction: -1));
    return true;
  }

  Future<void> next() async {
    if (!state.canContinue) return;
    if (!state.isLast) {
      emit(state.copyWith(step: state.step + 1, direction: 1));
      return;
    }
    emit(state.copyWith(saving: true));
    await _save(state.answers);
    emit(state.copyWith(saving: false, done: true));
  }
}
