import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Wires up every `@injectable`/`@lazySingleton` across the app. Generated
/// registrations live in `injection.config.dart` (run build_runner).
@InjectableInit()
void configureDependencies() => getIt.init();
