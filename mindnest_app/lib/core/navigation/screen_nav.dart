import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/navigation/tab_scope.dart';
import 'package:mindnest_app/routes/route_names.dart';

/// Lightweight navigation helpers used by the wellness screens. Backed by the
/// app's single GoRouter — the screens push named routes whose names match the
/// strings passed here, with any params delivered via `extra`.
extension ScreenNav on BuildContext {
  /// Push a named wellness route, forwarding [params] as `extra`.
  void pushScreen(String name, [Map<String, dynamic> params = const {}]) =>
      pushNamed(name, extra: params.isEmpty ? null : params);

  /// Pop the current screen.
  void popScreen() => pop();

  /// Switch the enclosing shell to tab [id] (e.g. 'journal', 'feed').
  void goShellTab(String id) => TabScope.maybeOf(this)?.go(id);

  /// Return to the wellness home tab (clears pushed screens).
  void goShellHome() =>
      goNamed(RouteNames.userShell, queryParameters: {'tab': 'home'});
}

/// Reads the `extra` map a [pushScreen] call delivered for the current route.
Map<String, dynamic> screenParams(GoRouterState state) =>
    state.extra is Map<String, dynamic>
    ? state.extra as Map<String, dynamic>
    : const {};
