import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._local);
  final SettingsLocalDataSource _local;

  @override
  ResultFuture<AppPreferences> load() => guard(() async => _local.read());

  @override
  ResultFuture<void> save(AppPreferences prefs) => guard(() => _local.write(prefs));
}
