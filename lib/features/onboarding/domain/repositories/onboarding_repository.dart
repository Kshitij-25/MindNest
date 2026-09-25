import '../../../../core/usecase/usecase.dart';
import '../entities/assessment.dart';

abstract interface class OnboardingRepository {
  ResultFuture<Assessment?> getAssessment();
  ResultFuture<void> saveAssessment(Assessment assessment);
}
