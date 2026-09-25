import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/app_preferences.dart';
import '../repositories/settings_repository.dart';

@injectable
class LoadPreferences implements UseCase<AppPreferences, NoParams> {
  const LoadPreferences(this._repo);
  final SettingsRepository _repo;

  @override
  ResultFuture<AppPreferences> call(NoParams params) => _repo.load();
}

@injectable
class SavePreferences implements UseCase<void, AppPreferences> {
  const SavePreferences(this._repo);
  final SettingsRepository _repo;

  @override
  ResultFuture<void> call(AppPreferences params) => _repo.save(params);
}
