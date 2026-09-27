import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_deletion_data_source.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._ds);
  final AccountDeletionDataSource _ds;

  @override
  bool get usesPassword => _ds.reauthMethod == ReauthMethod.password;

  @override
  ResultFuture<void> deleteAccount({String? password}) => guard(() => _ds.deleteAccount(password: password));
}
