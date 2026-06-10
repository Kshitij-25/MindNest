import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/onboarding_answers.dart';

abstract interface class OnboardingRepository {
  Future<Result<Unit>> saveAnswers(OnboardingAnswers answers);
}
