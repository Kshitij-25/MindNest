import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/settings/domain/entities/app_preferences.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';

class MindNestApp extends StatelessWidget {
  const MindNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthBloc>()),
        BlocProvider.value(value: getIt<SettingsCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, AppPreferences>(
        builder: (context, prefs) {
          final router = getIt<AppRouter>();
          return MaterialApp.router(
            title: 'MindNest',
            debugShowCheckedModeBanner: false,
            themeMode: prefs.themeMode,
            theme: AppTheme.light(highContrast: prefs.highContrast),
            darkTheme: AppTheme.dark(highContrast: prefs.highContrast),
            themeAnimationDuration: prefs.reduceMotion ? Duration.zero : const Duration(milliseconds: 300),
            routerConfig: router.config(),
            // Apply in-app accessibility preferences on top of OS settings.
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              final osScale = mq.textScaler.scale(1);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: TextScaler.linear((osScale * prefs.textScale).clamp(0.8, 2.0)),
                  disableAnimations: mq.disableAnimations || prefs.reduceMotion,
                  highContrast: mq.highContrast || prefs.highContrast,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
