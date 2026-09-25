import '../../../../core/usecase/usecase.dart';
import '../entities/app_preferences.dart';

abstract interface class SettingsRepository {
  ResultFuture<AppPreferences> load();
  ResultFuture<void> save(AppPreferences prefs);
}
