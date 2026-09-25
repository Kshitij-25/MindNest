import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'core/di/injection.dart';
import 'core/di/user_scope.dart';
import 'core/push/push_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  registerBackgroundPushHandler();
  await configureDependencies();
  await getIt<SettingsCubit>().init();

  final auth = getIt<AuthBloc>()..add(const AuthEvent.started());
  auth.stream
      .map((s) => s.status)
      .distinct()
      .where((s) => s == AuthStatus.unauthenticated)
      .listen((_) => resetUserScope());
  getIt<PushService>().start();

  runApp(const MindNestApp());
}
