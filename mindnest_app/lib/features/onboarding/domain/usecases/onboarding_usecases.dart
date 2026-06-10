import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/onboarding_answers.dart';
import '../repositories/onboarding_repository.dart';

@lazySingleton
class SaveOnboarding implements UseCase<Unit, OnboardingAnswers> {
  SaveOnboarding(this._repo);
  final OnboardingRepository _repo;
  @override
  Future<Result<Unit>> call(OnboardingAnswers answers) =>
      _repo.saveAnswers(answers);
}
