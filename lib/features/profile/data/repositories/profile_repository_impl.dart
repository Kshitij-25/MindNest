import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/network/mock_latency.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/profile_details.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._local);
  final ProfileLocalDataSource _local;

  @override
  ResultFuture<ProfileDetails> getDetails() => guard(() async => _local.read());

  @override
  ResultFuture<void> saveDetails(ProfileDetails d) => guard(() async {
        await mockLatency(400);
        await _local.write(d);
      });
}
