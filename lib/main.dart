import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // Local development against `firebase emulators:start`:
  //   flutter run --dart-define=USE_FIREBASE_EMULATOR=true
  if (const bool.fromEnvironment('USE_FIREBASE_EMULATOR')) {
    const host = String.fromEnvironment('FIREBASE_EMULATOR_HOST', defaultValue: 'localhost');
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  }
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
