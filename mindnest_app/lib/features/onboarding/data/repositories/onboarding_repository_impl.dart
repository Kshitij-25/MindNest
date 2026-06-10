import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/entities/onboarding_answers.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasource/onboarding_local_data_source.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._local);
  final OnboardingLocalDataSource _local;

  @override
  Future<Result<Unit>> saveAnswers(OnboardingAnswers answers) async {
    try {
      await _local.saveAnswers({
        'mood': answers.mood,
        'stress': answers.stress,
        'sleep': answers.sleep,
        'anxiety': answers.anxiety,
        'goals': answers.goals,
      });
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
