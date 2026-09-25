import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../models/assessment_model.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._local, this._remote);
  final OnboardingLocalDataSource _local;
  final OnboardingRemoteDataSource _remote;

  @override
  ResultFuture<Assessment?> getAssessment() => guard(() async {
        final local = _local.read();
        if (local != null) return local.toEntity();
        final remote = await _remote.read();
        if (remote != null) await _local.write(remote);
        return remote?.toEntity();
      });

  @override
  ResultFuture<void> saveAssessment(Assessment a) => guard(() async {
        final m = AssessmentModel.fromEntity(a);
        await _remote.write(m);
        await _local.write(m);
      });
}
