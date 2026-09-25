import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/network/mock_latency.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../models/assessment_model.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._local);
  final OnboardingLocalDataSource _local;

  @override
  ResultFuture<Assessment?> getAssessment() => guard(() async => _local.read()?.toEntity());

  @override
  ResultFuture<void> saveAssessment(Assessment a) => guard(() async {
        await mockLatency(300);
        await _local.write(AssessmentModel.fromEntity(a));
      });
}
