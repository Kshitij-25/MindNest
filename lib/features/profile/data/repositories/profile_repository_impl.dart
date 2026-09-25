import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/profile_details.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_data_source.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._ds);
  final ProfileDataSource _ds;

  @override
  ResultFuture<ProfileDetails> getDetails() => guard(_ds.read);

  @override
  ResultFuture<void> saveDetails(ProfileDetails d) => guard(() => _ds.write(d));
}
