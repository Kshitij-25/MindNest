import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/app_theme.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/features/settings/presentation/cubit/theme_cubit.dart';

/// Root widget: provides the global [ThemeCubit], wires the [GoRouter], and
/// keeps the experience phone-shaped + accessible on any screen size.
class MindNestApp extends StatelessWidget {
  const MindNestApp({super.key, required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp.router(
            title: 'MindNest',
            debugShowCheckedModeBanner: false,
            theme: buildMindNestTheme(Brightness.light),
            darkTheme: buildMindNestTheme(Brightness.dark),
            themeMode: mode,
            routerConfig: router,
            builder: (context, child) =>
                _ResponsiveFrame(child: child ?? const SizedBox.shrink()),
          );
        },
      ),
    );
  }
}

class _ResponsiveFrame extends StatelessWidget {
  const _ResponsiveFrame({required this.child});
  final Widget child;

  static const double _maxWidth = 460;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final media = MediaQuery.of(context);
    final scaled = media.copyWith(
      textScaler: media.textScaler.clamp(
        minScaleFactor: 0.9,
        maxScaleFactor: 1.3,
      ),
    );

    Widget framed;
    if (media.size.width <= _maxWidth + 0.5) {
      framed = MediaQuery(data: scaled, child: child);
    } else {
      framed = ColoredBox(
        color: c.bg2,
        child: Center(
          child: ClipRect(
            child: SizedBox(
              width: _maxWidth,
              height: media.size.height,
              child: MediaQuery(
                data: scaled.copyWith(size: Size(_maxWidth, media.size.height)),
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: DefaultTextStyle(
        style: MnText.body.copyWith(color: c.ink),
        child: framed,
      ),
    );
  }
}
