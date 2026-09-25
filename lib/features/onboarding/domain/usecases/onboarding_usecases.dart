import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/assessment.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class SaveAssessment implements UseCase<void, Assessment> {
  const SaveAssessment(this._repo);
  final OnboardingRepository _repo;

  @override
  ResultFuture<void> call(Assessment a) => _repo.saveAssessment(a);
}

@injectable
class GetAssessment implements UseCase<Assessment?, NoParams> {
  const GetAssessment(this._repo);
  final OnboardingRepository _repo;

  @override
  ResultFuture<Assessment?> call(NoParams _) => _repo.getAssessment();
}
