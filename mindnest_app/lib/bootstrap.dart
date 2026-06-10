import 'package:flutter/widgets.dart';
import 'package:mindnest_app/app.dart';
import 'package:mindnest_app/core/config/app_config.dart';
import 'package:mindnest_app/core/config/env.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/routes/app_router.dart';

/// Composition root: initialize config + DI, then run the app.
Future<void> bootstrap(Env env) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init(env);
  configureDependencies();
  // Restore a persisted session before routing so a logged-in user skips the
  // auth screens on restart.
  final session = getIt<SessionService>();
  await session.restore();
  final router = AppRouter(session).router;
  runApp(MindNestApp(router: router));
}
